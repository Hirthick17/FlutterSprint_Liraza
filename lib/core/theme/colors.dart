import 'package:flutter/material.dart';

/// Color constants for LIRAZA app - Empathy & Support Theme
class AppColors {
  // Core Colors
  static const Color hotPink = Color(0xFFFF1493);        // Hot Pink - Energy & Hope
  static const Color deepPink = Color(0xFFFF69B4);       // Deep Pink - Warmth
  static const Color softPink = Color(0xFFFFB6C1);       // Soft Pink - Gentleness
  static const Color blushPink = Color(0xFFFFC0CB);      // Blush Pink - Comfort

  // Neutrals
  static const Color pureWhite = Color(0xFFFFFFFF);      // Pure White - Clarity
  static const Color softWhite = Color(0xFFFAFAFA);      // Soft White - Background
  static const Color lightGray = Color(0xFFF5F5F5);      // Light Gray - Subtle surfaces
  static const Color warmGray = Color(0xFFE0E0E0);       // Warm Gray - Borders
  static const Color darkGray = Color(0xFF2D2D2D);       // For text

  // Aliases for compatibility with existing code
  static const Color primaryPink = hotPink;
  static const Color primaryMagenta = deepPink; // Using deepPink as magenta alias for now
  static const Color accentPink = deepPink; // Added for compatibility
  static const Color lightPink = Color(0xFFFFB6D9); // Added back for compatibility
  static const Color cardBackground = softWhite;
  static const Color surfaceWhite = pureWhite;
  static const Color textPrimary = darkGray;
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnGradient = Colors.white; // Added back for compatibility
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color divider = warmGray;
  static const Color primaryPurple = Color(0xFF9C27B0); // Added for compatibility
  static const Color shadowLight = Color(0x14FF1493); // Hot pink with low opacity

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [hotPink, deepPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGradient = LinearGradient(
    colors: [softPink, blushPink, pureWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Emotion Colors
  static const Map<String, Color> emotionColors = {
    'happy': Color(0xFFFFD700),    // Joy/Happy (Gold)
    'sad': Color(0xFF9FA8DA),      // Sad (Indigo)
    'anxious': Color(0xFFFFB347),  // Anxious (Orange)
    'angry': Color(0xFFF44336),    // Red
    'neutral': Color(0xFF9E9E9E),  // Gray
    'calm': Color(0xFF87CEEB),     // Calm (Sky Blue)
  };
  
  // Mood Score Gradient
  static const List<Color> moodGradient = [
    Color(0xFFF44336), // Red
    Color(0xFFFFB347), // Orange
    Color(0xFFFFD700), // Yellow
    Color(0xFF8BC34A), // Light Green
    Color(0xFF4CAF50), // Green
  ];

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Helper methods
  static Color getEmotionColor(String emotion) {
    return emotionColors[emotion.toLowerCase()] ?? emotionColors['neutral']!;
  }
  
  static Color getMoodColor(double score) {
    if (score <= 2) return moodGradient[0];
    if (score <= 4) return moodGradient[1];
    if (score <= 6) return moodGradient[2];
    if (score <= 8) return moodGradient[3];
    return moodGradient[4];
  }
}
