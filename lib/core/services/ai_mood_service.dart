import 'package:google_generative_ai/google_generative_ai.dart';
import '../constants/app_constants.dart';
import '../../features/home/services/mood_service.dart';

class AiMoodService {
  final MoodService _moodService;
  late final GenerativeModel _model;

  AiMoodService(this._moodService) {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: AppConstants.geminiApiKey,
    );
  }

  Future<Map<String, String>> generateMoodSuggestion() async {
    try {
      // Get recent mood history
      final moodHistory = await _moodService.getMoodHistory(days: 7);
      
      if (moodHistory.isEmpty) {
        return {
          'title': 'Start Your Journey',
          'description': 'Begin logging your moods to receive personalized suggestions.',
          'action': 'Log your first mood to get started!',
        };
      }

      // Analyze mood patterns
      final moodCounts = <String, int>{};
      for (var log in moodHistory) {
        final mood = log['mood'] as String;
        moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
      }

      final dominantMood = moodCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;

      // Create prompt for Gemini
      final prompt = '''
You are a compassionate mental health AI assistant. Based on the user's recent mood pattern, provide a brief, actionable suggestion.

Recent mood distribution (last 7 days):
${moodCounts.entries.map((e) => '${e.key}: ${e.value} times').join(', ')}

Dominant mood: $dominantMood

Provide a response in this exact JSON format:
{
  "title": "A short, encouraging title (max 5 words)",
  "description": "A brief, empathetic description of what you notice (max 20 words)",
  "action": "One specific, actionable suggestion they can try today (max 15 words)"
}

Keep it warm, supportive, and practical. Focus on small, achievable actions.
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      final text = response.text ?? '';

      // Parse JSON response
      final jsonMatch = RegExp(r'\{[^}]+\}').firstMatch(text);
      if (jsonMatch != null) {
        final jsonStr = jsonMatch.group(0)!;
        // Simple JSON parsing (you might want to use dart:convert for production)
        final titleMatch = RegExp(r'"title":\s*"([^"]+)"').firstMatch(jsonStr);
        final descMatch = RegExp(r'"description":\s*"([^"]+)"').firstMatch(jsonStr);
        final actionMatch = RegExp(r'"action":\s*"([^"]+)"').firstMatch(jsonStr);

        return {
          'title': titleMatch?.group(1) ?? 'Keep Going',
          'description': descMatch?.group(1) ?? 'You\'re making progress on your mental health journey.',
          'action': actionMatch?.group(1) ?? 'Try a 5-minute breathing exercise today.',
        };
      }

      // Fallback if parsing fails
      return _getFallbackSuggestion(dominantMood);
    } catch (e) {
      return _getFallbackSuggestion('Okay');
    }
  }

  Map<String, String> _getFallbackSuggestion(String mood) {
    switch (mood) {
      case 'Happy':
        return {
          'title': 'Celebrate Your Joy! 🎉',
          'description': 'You\'ve been feeling great lately!',
          'action': 'Share your happiness with someone today.',
        };
      case 'Good':
        return {
          'title': 'Positive Momentum 💪',
          'description': 'You\'re maintaining a good mood.',
          'action': 'Keep up your healthy habits!',
        };
      case 'Okay':
        return {
          'title': 'Steady Progress 🌱',
          'description': 'You\'re staying balanced.',
          'action': 'Try adding one small joy to your day.',
        };
      case 'Low':
        return {
          'title': 'Be Kind to Yourself 💙',
          'description': 'It\'s okay to have difficult days.',
          'action': 'Take a short walk or call a friend.',
        };
      case 'Sad':
        return {
          'title': 'We\'re Here for You 🤗',
          'description': 'Remember, this feeling is temporary.',
          'action': 'Reach out to someone you trust today.',
        };
      default:
        return {
          'title': 'One Day at a Time',
          'description': 'Every step forward counts.',
          'action': 'Practice self-compassion today.',
        };
    }
  }
}
