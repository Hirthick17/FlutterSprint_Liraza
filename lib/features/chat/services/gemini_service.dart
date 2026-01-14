import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/privacy/pii_filter.dart';

class GeminiService {
  late final GenerativeModel _model;
  late ChatSession _chat;
  
  // System prompt to guide the AI's behavior
  static const String _systemPrompt = '''
You are LIRAZA, an empathetic and supportive AI mental health companion. 
Your goal is to provide a safe, non-judgmental space for users to share their feelings.
- validate their emotions
- ask gentle, open-ended questions
- provide comforting support and practical coping strategies (breathing, mindfulness)
- NEVER give medical diagnoses or prescriptions
- If the user expresses self-harm or suicidal thoughts, immediately provide crisis resources (helplines) and encourage professional help.
- Keep responses concise, warm, and human-like.
''';

  GeminiService() {
    _initModel();
  }

  void _initModel() {
    _model = GenerativeModel(
      model: AppConstants.aiModel,
      apiKey: AppConstants.geminiApiKey,
      systemInstruction: Content.system(_systemPrompt),
    );
    _chat = _model.startChat();
  }

  Future<Map<String, dynamic>> sendMessage(String message) async {
    try {
      if (AppConstants.geminiApiKey.isEmpty || AppConstants.geminiApiKey.startsWith('YOUR_')) {
        return {
          'text': "I'm having a bit of trouble connecting to my brain right now. Please check api key.",
          'isCrisis': false,
        };
      }

      // 1. Run Local Privacy & Sentiment Analysis
      final privacyResult = PIIFilter.filterMessage(message);
      final anonymizedMessage = privacyResult['anonymized'];
      final emotion = PIIFilter.detectEmotion(message);
      final sentiment = PIIFilter.calculateSentiment(message);
      final hasPII = privacyResult['has_pii'];

      // 2. Check for Crisis (Local Fail-safe)
      if (emotion == 'CRISIS') {
        return {
          'text': "I'm detecting that you might be going through a crisis. Please remember you are not alone.",
          'isCrisis': true,
          'sentiment': sentiment,
        };
      }

      // 3. Construct Context-Aware Prompt
      final contextPrompt = '''
[SYSTEM_CONTEXT]
Detected Emotion: $emotion
Sentiment Score: $sentiment (-5 to +5)
Has PII Redacted: $hasPII

[USER_MESSAGE]
$anonymizedMessage

[INSTRUCTION]
Respond to the user message with empathy matching their detected emotion. 
If PII was redacted (placeholder like [PERSON]), do not mention the redaction, just flow naturally.
Keep response concise and supportive.
''';

      // 4. Send to Gemini
      final content = Content.text(contextPrompt);
      final response = await _chat.sendMessage(content);
      
      final responseText = response.text;
      
      if (responseText != null && responseText.isNotEmpty) {
        return {
          'text': responseText,
          'isCrisis': false,
          'emotion': emotion,
          'sentiment': sentiment,
        };
      } else {
         return {
          'text': "I'm not sure what to say. Could you try again?",
          'isCrisis': false,
        };
      }
    } catch (e) {
      print('Gemini API Error: $e');
      String errorMsg = "I'm having trouble connecting right now. Please try again.";
      
      if (e.toString().contains('User location is not supported')) {
         errorMsg = "It looks like I'm unable to access the AI service in your current location.";
      } else if (e.toString().contains('404') || e.toString().contains('not found')) {
        errorMsg = "I'm having trouble connecting to the AI model. Please check API Key.";
      }
      
      return {
        'text': errorMsg,
        'isCrisis': false,
      };
    }
  }

  void clearHistory() {
    // To clear history, we simply start a new chat session
    _chat = _model.startChat();
  }

  /// Generate habit suggestions based on user's emotional patterns
  Future<List<Map<String, String>>> generateHabitSuggestions({
    required String dominantEmotion,
    required List<String> recentMoods,
  }) async {
    final prompt = '''
Based on a user experiencing primarily "$dominantEmotion" emotions, suggest 5 daily habits to improve mental wellbeing.

Recent mood pattern: ${recentMoods.join(', ')}

Return ONLY a JSON array with this exact format:
[
  {"habit": "Morning gratitude journaling", "time": "08:00", "frequency": "daily", "benefit": "Increases positive thinking"},
  ...
]

Keep habits realistic, science-backed, and actionable.
''';
    
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '[]';
      
      // Extract JSON from response (handle markdown fences)
      final jsonStr = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      
      final List<dynamic> habits = jsonDecode(jsonStr);
      return habits.map((h) => Map<String, String>.from(h)).toList();
    } catch (e) {
      print('GenHabit Error: $e');
      // Fallback habits
      return [
        {'habit': 'Morning meditation', 'time': '07:00', 'frequency': 'daily', 'benefit': 'Reduces stress'},
        {'habit': 'Evening walk', 'time': '18:00', 'frequency': 'daily', 'benefit': 'Improves mood'},
        {'habit': 'Hydration goal', 'time': '10:00', 'frequency': 'daily', 'benefit': 'Physical wellbeing'},
      ];
    }
  }
}
