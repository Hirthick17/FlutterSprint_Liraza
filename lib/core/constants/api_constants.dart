/// API and configuration constants
class ApiConstants {
  // Cloud Functions
  static const String analyzeMoodFromChatFunction = 'analyzeMoodFromChat';
  static const String generateAIResponseFunction = 'generateAIResponse';
  static const String findNearbyTherapistsFunction = 'findNearbyTherapists';
  
  // Gemini API
  static const String geminiModel = 'gemini-pro';
  static const int geminiMaxTokens = 1000;
  static const double geminiTemperature = 0.7;
  
  // Google Maps
  static const double defaultLatitude = 19.0760; // Mumbai
  static const double defaultLongitude = 72.8777;
  static const double defaultZoom = 14.0;
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration chatResponseTimeout = Duration(seconds: 15);
  static const Duration moodAnalysisTimeout = Duration(seconds: 10);
}
