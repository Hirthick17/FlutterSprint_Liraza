import 'package:flutter/material.dart';

/// Color constants for LIRAZA app
/// Magenta gradient theme matching the UI template
class AppColors {
  // Primary Gradient Colors
  static const Color primaryMagenta = Color(0xFFFF0099);
  static const Color primaryPink = Color(0xFFFF1493);
  static const Color accentPink = Color(0xFFFF69B4);
  static const Color lightPink = Color(0xFFFFB6D9);
  
  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryMagenta,
      primaryPink,
      accentPink,
    ],
  );
  
  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryPink,
      accentPink,
    ],
  );
  
  // Surface Colors
  static const Color cardBackground = Color(0xFFFFF0F5); // Soft pink-white
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color overlayLight = Color(0xFFFAFAFA);
  static const Color divider = Color(0xFFE0E0E0);
  
  // Text Colors
  static const Color textOnGradient = Color(0xFFFFFFFF); // White on gradient
  static const Color textPrimary = Color(0xFF2D2D2D); // Dark gray
  static const Color textSecondary = Color(0xFF757575); // Medium gray
  static const Color textHint = Color(0xFFBDBDBD); // Light gray
  
  // Emotion Colors (for mood tracking)
  static const Map<String, Color> emotionColors = {
    'happy': Color(0xFF4CAF50),    // Green
    'sad': Color(0xFF2196F3),      // Blue
    'anxious': Color(0xFFFF9800),  // Orange
    'angry': Color(0xFFF44336),    // Red
    'neutral': Color(0xFF9E9E9E),  // Gray
    'calm': Color(0xFF98D8C8),     // Mint green
  };
  
  // Mood Score Gradient (for charts)
  static const List<Color> moodGradient = [
    Color(0xFFF44336), // Red (score 1-2)
    Color(0xFFFF9800), // Orange (score 3-4)
    Color(0xFFFFEB3B), // Yellow (score 5-6)
    Color(0xFF8BC34A), // Light green (score 7-8)
    Color(0xFF4CAF50), // Green (score 9-10)
  ];
  
  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Chat Bubble Colors
  static const Color userBubble = primaryPink;
  static const Color aiBubble = surfaceWhite;
  static const Color aiBubbleBorder = Color(0xFFE0E0E0);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // 10% black
  static const Color shadowMedium = Color(0x33000000); // 20% black
  
  // Helper method to get emotion color
  static Color getEmotionColor(String emotion) {
    return emotionColors[emotion.toLowerCase()] ?? emotionColors['neutral']!;
  }
  
  // Helper method to get mood color based on score (1-10)
  static Color getMoodColor(double score) {
    if (score <= 2) return moodGradient[0];
    if (score <= 4) return moodGradient[1];
    if (score <= 6) return moodGradient[2];
    if (score <= 8) return moodGradient[3];
    return moodGradient[4];
  }
}
