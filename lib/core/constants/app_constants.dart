/// App-wide constants for LIRAZA
class AppConstants {
  // App Info
  static const String appName = 'LIRAZA';
  static const String appTagline = 'Your AI Companion for Emotional Wellness';
  
  // Mood Labels
  static const List<String> moodLabels = [
    'Very Sad',
    'Sad',
    'Anxious',
    'Neutral',
    'Okay',
    'Content',
    'Happy',
    'Very Happy',
    'Excited',
    'Joyful',
  ];
  
  // Emotion Types
  static const List<String> emotionTypes = [
    'happy',
    'sad',
    'anxious',
    'angry',
    'neutral',
    'calm',
  ];
  
  // Mood Emojis (1-10 scale)
  static const Map<int, String> moodEmojis = {
    1: '😢',
    2: '😔',
    3: '😰',
    4: '😐',
    5: '🙂',
    6: '😊',
    7: '😄',
    8: '😁',
    9: '🤩',
    10: '🎉',
  };
  
  // Emotion Emojis
  static const Map<String, String> emotionEmojis = {
    'happy': '😊',
    'sad': '😔',
    'anxious': '😰',
    'angry': '😠',
    'neutral': '😐',
    'calm': '😌',
  };
  
  // Chat Settings
  static const int moodAnalysisInterval = 4; // Analyze every 4 messages
  static const int maxMessageLength = 500;
  static const int conversationHistoryLimit = 10;
  
  // Rate Limiting
  static const int maxAIRequestsPerHour = 10;
  static const int maxChatSessionsPerDay = 20;
  
  // Mood Thresholds
  static const double lowMoodThreshold = 4.0;
  static const double highMoodThreshold = 7.0;
  static const int consecutiveLowMoodAlert = 2;
  
  // Crisis Keywords
  static const List<String> crisisKeywords = [
    'suicide',
    'kill myself',
    'end it all',
    'don\'t want to live',
    'self harm',
    'cut myself',
    'hurt myself',
    'overdose',
    'want to die',
    'no reason to live',
  ];
  
  // Crisis Helplines (India)
  static const Map<String, String> crisisHelplines = {
    'AASRA': '9152987821',
    'Vandrevala Foundation': '18602662345',
    'iCall': '9152987821',
    'Sneha India': '04424640050',
  };
  
  // Dashboard Settings
  static const int defaultDashboardDays = 7;
  static const int maxDashboardDays = 30;
  static const int minDataPointsForAnalysis = 3;
  
  // Therapist Search
  static const double defaultSearchRadiusKm = 10.0;
  static const double maxSearchRadiusKm = 50.0;
  static const int maxTherapistResults = 20;
  
  // Therapist Specialties
  static const List<String> therapistSpecialties = [
    'Anxiety',
    'Depression',
    'Stress Management',
    'Relationship Issues',
    'Trauma',
    'Grief',
    'Addiction',
    'Eating Disorders',
    'Sleep Issues',
    'General Counseling',
  ];
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Pagination
  static const int moodLogsPageSize = 20;
  static const int chatMessagesPageSize = 50;
  
  // Cache Duration
  static const Duration cacheExpiry = Duration(hours: 1);
  
  // Positive Messages
  static const List<String> positiveMessages = [
    'You\'re doing great! Keep going! 💪',
    'Every day is a new opportunity for growth 🌱',
    'Your mental health journey matters 💜',
    'You\'re stronger than you think 🌟',
    'Progress, not perfection ✨',
    'You\'re not alone in this journey 🤝',
    'Small steps lead to big changes 🚶',
    'Be kind to yourself today 💝',
    'You\'re worthy of happiness 🌈',
    'Your feelings are valid 💙',
  ];
  
  // Encouraging Messages (for improving mood)
  static const List<String> encouragingMessages = [
    'Your mood is improving! That\'s wonderful progress! 📈',
    'You\'ve shown resilience this week - proud of you! 🎯',
    'Keep up the positive momentum! 🌟',
    'You\'re on an upward trend - amazing! 🚀',
    'Your efforts are paying off! 💪',
  ];
  
  // Supportive Messages (for low mood)
  static const List<String> supportiveMessages = [
    'It\'s okay to have difficult days. You\'re not alone 💙',
    'Remember, this feeling is temporary 🌤️',
    'Be gentle with yourself today 🤗',
    'Reaching out for support is a sign of strength 💪',
    'You\'ve overcome challenges before, you can do it again 🌟',
  ];
}
