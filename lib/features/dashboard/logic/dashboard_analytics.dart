import 'dart:math';
import '../models/dashboard_models.dart';

class DashboardAnalytics {
  
  // Calculate overall mental health score (0-10)
  static double calculateOverallScore(List<MoodLog> logs) {
    if (logs.isEmpty) return 7.0; // Default baseline

    double weightedSum = 0;
    double totalWeight = 0;
    final now = DateTime.now();

    for (var log in logs) {
      final daysDiff = now.difference(log.timestamp).inDays;
      double weight = 1.0;

      if (daysDiff <= 3) {
        weight = 5.0; // Last 3 days: 50% impact relative to others
      } else if (daysDiff <= 7) {
        weight = 3.0;
      } else if (daysDiff <= 30) {
        weight = 1.0;
      } else {
        weight = 0.5;
      }

      weightedSum += log.score * weight;
      totalWeight += weight;
    }

    if (totalWeight == 0) return 7.0;
    return double.parse((weightedSum / totalWeight).toStringAsFixed(1));
  }
  
  static BehaviorPattern analyzeBehaviors(List<ChatSession> sessions, List<MoodLog> logs) {
    return BehaviorPattern(
      mostActiveTimeOfDay: _findPeakActivityHour(sessions),
      moodTrend: _calculateTrend(logs),
      streakDays: _calculateStreak(logs),
      avgNightMood: _calculateAvgNightMood(logs),
    );
  }
  
  static String _findPeakActivityHour(List<ChatSession> sessions) {
    if (sessions.isEmpty) return 'afternoon';
    
    Map<String, int> timeSlots = {
      'morning': 0,
      'afternoon': 0,
      'evening': 0,
      'night': 0,
    };

    for (var session in sessions) {
      final hour = session.startTime.hour;
      if (hour >= 5 && hour < 12) timeSlots['morning'] = (timeSlots['morning'] ?? 0) + 1;
      else if (hour >= 12 && hour < 17) timeSlots['afternoon'] = (timeSlots['afternoon'] ?? 0) + 1;
      else if (hour >= 17 && hour < 21) timeSlots['evening'] = (timeSlots['evening'] ?? 0) + 1;
      else timeSlots['night'] = (timeSlots['night'] ?? 0) + 1;
    }

    // sort
    var sorted = timeSlots.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }

  static String _calculateTrend(List<MoodLog> logs) {
    if (logs.length < 2) return 'stable';
    // Simple linear regression or comparison of first vs last half
    logs.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    final recent = logs.take(logs.length ~/ 2).fold(0, (sum, log) => sum + log.score);
    final older = logs.skip(logs.length ~/ 2).fold(0, (sum, log) => sum + log.score);
    
    final recentAvg = recent / (logs.length / 2);
    final olderAvg = older / (logs.length / 2);

    if (recentAvg > olderAvg + 1) return 'improving';
    if (recentAvg < olderAvg - 1) return 'declining';
    return 'stable';
  }

  static int _calculateStreak(List<MoodLog> logs) {
    if (logs.isEmpty) return 0;
    int streak = 0;
    final now = DateTime.now();
    // Simplified logic
    // Check consecutive days with logs
    return 5; // Placeholder for logic
  }

  static double _calculateAvgNightMood(List<MoodLog> logs) {
    final nightLogs = logs.where((l) => l.timestamp.hour >= 20 || l.timestamp.hour < 5);
    if (nightLogs.isEmpty) return 0.0;
    final sum = nightLogs.fold(0, (s, l) => s + l.score);
    return sum / nightLogs.length;
  }
  
  // Generate insights
  static List<Insight> generateInsights(BehaviorPattern pattern, List<MoodLog> logs) {
    List<Insight> insights = [];
    
    // Achievement insights
    if (pattern.streakDays >= 5) {
      insights.add(Insight(
        id: 'streak_5',
        type: InsightType.achievement,
        title: "🎉 5-Day Streak!",
        message: "You've maintained positive mood for 5 days. Keep it up!",
      ));
    }
    
    // Warning insights
    if (pattern.moodTrend == "declining") {
      insights.add(Insight(
        id: 'mood_decline',
        type: InsightType.warning,
        title: "⚠️ Mood Declining",
        message: "We've noticed your mood dropping. Consider talking to someone.",
        actionable: true,
        actionText: "Find Therapist",
      ));
    }
    
    // Pattern insights
    if (pattern.mostActiveTimeOfDay == "night" && pattern.avgNightMood < 5) {
      insights.add(Insight(
        id: 'night_anxiety',
        type: InsightType.tip,
        title: "🌙 Evening Pattern",
        message: "You tend to feel more anxious at night. Try relaxation before bed.",
        actionable: true,
        actionText: "Breathing Exercise",
      ));
    }
    
    return insights;
  }
  
  static String generatePositiveMessage(double currentScore, String trend, int streakDays) {
    if (trend == "improving") {
      return "Your mood is improving! Keep riding this wave of positivity.";
    } else if (currentScore >= 7) {
      return "You're doing great! Your resilience is showing.";
    } else if (streakDays > 0) {
      return "Day $streakDays of your journey! Every step counts.";
    } else {
      return "Every day is a new opportunity. Be kind to yourself today.";
    }
  }

  static Map<String, int> getEmotionDistribution(List<MoodLog> logs) {
    Map<String, int> distribution = {};
    for (var log in logs) {
      distribution[log.emotion] = (distribution[log.emotion] ?? 0) + 1;
    }
    return distribution;
  }

  static WeeklyStats calculateWeeklyStats(List<ChatSession> sessions, List<MoodLog> logs) {
    // Calculates placeholder stats
    return WeeklyStats(
      totalSessions: sessions.length,
      avgDuration: sessions.isEmpty ? 0 : (sessions.fold(0, (s, sess) => s + sess.durationMinutes) / sessions.length).round(),
      moodImprovement: 12.0, // Calculated actual impl needed
      streak: 5,
    );
  }
}
