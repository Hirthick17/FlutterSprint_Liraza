import 'package:flutter/material.dart';

enum InsightType { achievement, warning, tip }

class MoodLog {
  final String id;
  final DateTime timestamp;
  final int score; // 1-10
  final String emotion; // happy, sad, anxious, etc.
  final String note;
  final List<String> activities;

  MoodLog({
    required this.id,
    required this.timestamp,
    required this.score,
    required this.emotion,
    this.note = '',
    this.activities = const [],
  });
}

class ChatSession {
  final String id;
  final DateTime startTime;
  final int durationMinutes;
  final List<String> topics;

  ChatSession({
    required this.id,
    required this.startTime,
    required this.durationMinutes,
    required this.topics,
  });
}

class BehaviorPattern {
  final String mostActiveTimeOfDay;
  final String moodTrend; // improving, declining, stable
  final List<String> triggerPatterns;
  final List<String> copingStrategies;
  final int streakDays;
  final double avgNightMood;

  BehaviorPattern({
    this.mostActiveTimeOfDay = 'afternoon',
    this.moodTrend = 'stable',
    this.triggerPatterns = const [],
    this.copingStrategies = const [],
    this.streakDays = 0,
    this.avgNightMood = 0.0,
  });
}

class Insight {
  final String id;
  final InsightType type;
  final String title;
  final String message;
  final bool actionable;
  final String? actionText;
  final VoidCallback? onAction;

  Insight({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.actionable = false,
    this.actionText,
    this.onAction,
  });
}

class WeeklyStats {
  final int totalSessions;
  final int avgDuration; // minutes
  final double moodImprovement; // percentage
  final int streak;

  WeeklyStats({
    this.totalSessions = 0,
    this.avgDuration = 0,
    this.moodImprovement = 0.0,
    this.streak = 0,
  });
}

class DashboardState {
  final bool isLoading;
  final double overallScore;
  final String? error;
  final BehaviorPattern? pattern;
  final List<Insight> insights;
  final String positiveMessage;
  final WeeklyStats weeklyStats;
  final Map<String, int> emotionDistribution;
  final List<MoodLog> moodLogs;

  DashboardState({
    this.isLoading = false,
    this.overallScore = 0.0,
    this.error,
    this.pattern,
    this.insights = const [],
    this.positiveMessage = '',
    required this.weeklyStats,
    this.emotionDistribution = const {},
    this.moodLogs = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    double? overallScore,
    String? error,
    BehaviorPattern? pattern,
    List<Insight>? insights,
    String? positiveMessage,
    WeeklyStats? weeklyStats,
    Map<String, int>? emotionDistribution,
    List<MoodLog>? moodLogs,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      overallScore: overallScore ?? this.overallScore,
      error: error, // Reset error on copy usually, or keep if error passed
      pattern: pattern ?? this.pattern,
      insights: insights ?? this.insights,
      positiveMessage: positiveMessage ?? this.positiveMessage,
      weeklyStats: weeklyStats ?? this.weeklyStats,
      emotionDistribution: emotionDistribution ?? this.emotionDistribution,
      moodLogs: moodLogs ?? this.moodLogs,
    );
  }
}
