import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';

class GeminiService {
  final List<Map<String, String>> _chatHistory = [];
  
  // OpenRouter Configuration
  static const String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  
  // System prompt to guide the AI's behavior
  static const String _systemPrompt = '''
You are LIRAZA, an empathetic and supportive AI mental health companion. 
Your goal is to provide a safe, non-judgmental space for users to share their feelings.
- validated their emotions
- ask gentle, open-ended questions
- provide comforting support and practical coping strategies (breathing, mindfulness)
- NEVER give medical diagnoses or prescriptions
- If the user expresses self-harm or suicidal thoughts, immediately provide crisis resources (helplines) and encourage professional help.
- Keep responses concise, warm, and human-like.
''';

  GeminiService() {
    // Initialize history with system prompt if desired, 
    // though OpenRouter usually handles system messages separately or as the first message.
    _chatHistory.add({'role': 'system', 'content': _systemPrompt});
  }

  Future<String> sendMessage(String message) async {
    try {
      if (AppConstants.geminiApiKey.isEmpty || AppConstants.geminiApiKey.startsWith('YOUR_')) {
        return "I'm having a bit of trouble connecting to my brain right now. Please check api key.";
      }

      // Add user message to history
      _chatHistory.add({'role': 'user', 'content': message});

      // Prepare payload
      // We limit history to last 10-20 messages to save context/tokens if needed, 
      // but including the system prompt is important.
      final messagesToSend = [
        {'role': 'system', 'content': _systemPrompt},
        ..._chatHistory.where((m) => m['role'] != 'system').toList().take(20) // naive limiting
      ];

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer ${AppConstants.geminiApiKey}',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://github.com/Hirthick17/FlutterSprint_Liraza', // Optional
          'X-Title': 'Liraza Mental Health App', // Optional
        },
        body: jsonEncode({
          'model': AppConstants.aiModel,
          'messages': messagesToSend,
          // Optional parameters
          'temperature': 0.7,
          'top_p': 0.9,
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final content = data['choices'][0]['message']['content'];
          
          // Add AI response to history
          _chatHistory.add({'role': 'assistant', 'content': content});
          
          return content;
        } else {
          return "I'm not sure what to say. Could you try again?";
        }
      } else {
        print('OpenRouter API Error: ${response.statusCode} - ${response.body}');
        return "I'm having trouble connecting (Error ${response.statusCode}). Please try again.";
      }
    } catch (e) {
      print('Network Error: $e');
      return "I'm unable to reach the server right now. Please check your internet connection.";
    }
  }

  void clearHistory() {
    _chatHistory.clear();
    _chatHistory.add({'role': 'system', 'content': _systemPrompt});
  }
}
