import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_models.dart';
import '../logic/dashboard_analytics.dart';
import '../repositories/dashboard_repository.dart';

class DashboardProvider extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;
  
  DashboardProvider(this._repository) : super(DashboardState(weeklyStats: WeeklyStats()));

  Future<void> loadDashboardData(String userId) async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Fetch Real Data - DISABLED to fix loading speed issue
      // final now = DateTime.now();
      // final startDate = now.subtract(const Duration(days: 30));
      
      // var moodLogs = await _repository.getMoodLogs(userId, startDate);
      // var chatSessions = await _repository.getChatSessions(userId, startDate);

      // Force Mock Data for Instant Loading
      var moodLogs = _generateMockMoodLogs();
      var chatSessions = _generateMockChatSessions();
      
      // Calculate Analytics
      final overallScore = DashboardAnalytics.calculateOverallScore(moodLogs);
      final pattern = DashboardAnalytics.analyzeBehaviors(chatSessions, moodLogs);
      final insights = DashboardAnalytics.generateInsights(pattern, moodLogs);
      final weeklyStats = DashboardAnalytics.calculateWeeklyStats(chatSessions, moodLogs);
      final emotionDist = DashboardAnalytics.getEmotionDistribution(moodLogs);
      final positiveMsg = DashboardAnalytics.generatePositiveMessage(overallScore, pattern.moodTrend, pattern.streakDays);

      state = state.copyWith(
        isLoading: false,
        overallScore: overallScore,
        pattern: pattern,
        insights: insights,
        positiveMessage: positiveMsg,
        weeklyStats: weeklyStats,
        emotionDistribution: emotionDist,
        moodLogs: moodLogs,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void refreshPositiveMessage() {
     // Implement refresh logic
  }
  
  void dismissInsight(String insightId) {
    final updatedInsights = state.insights.where((i) => i.id != insightId).toList();
    state = state.copyWith(insights: updatedInsights);
  }

  // MOCK DATA GENERATORS
  List<MoodLog> _generateMockMoodLogs() {
    final now = DateTime.now();
    return [
      MoodLog(id: '1', timestamp: now.subtract(const Duration(days: 0)), score: 8, emotion: 'happy'),
      MoodLog(id: '2', timestamp: now.subtract(const Duration(days: 1)), score: 7, emotion: 'calm'),
      MoodLog(id: '3', timestamp: now.subtract(const Duration(days: 2)), score: 6, emotion: 'neutral'),
      MoodLog(id: '4', timestamp: now.subtract(const Duration(days: 3)), score: 5, emotion: 'anxious'),
      MoodLog(id: '5', timestamp: now.subtract(const Duration(days: 4)), score: 7, emotion: 'happy'),
      MoodLog(id: '6', timestamp: now.subtract(const Duration(days: 5)), score: 8, emotion: 'happy'),
      MoodLog(id: '7', timestamp: now.subtract(const Duration(days: 6)), score: 6, emotion: 'neutral'),
    ];
  }

  List<ChatSession> _generateMockChatSessions() {
     final now = DateTime.now();
     return [
       ChatSession(id: '1', startTime: now.subtract(const Duration(hours: 2)), durationMinutes: 15, topics: ['stress']),
       ChatSession(id: '2', startTime: now.subtract(const Duration(days: 1, hours: 4)), durationMinutes: 10, topics: ['sleep']),
       ChatSession(id: '3', startTime: now.subtract(const Duration(days: 3, hours: 20)), durationMinutes: 20, topics: ['anxiety']),
     ];
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

final dashboardProvider = StateNotifierProvider<DashboardProvider, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardProvider(repository);
});
