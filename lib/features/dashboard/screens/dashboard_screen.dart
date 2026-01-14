import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/dashboard_models.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/emotional_analysis.dart';
import '../widgets/insight_card.dart';
import '../widgets/mood_trend_chart.dart';
import '../widgets/overall_health_score_widget.dart';
import '../../habits/screens/habit_suggestions_screen.dart';
import '../../../core/animations/fade_in_up.dart';
import '../widgets/behavior_pattern_card.dart';
import '../widgets/weekly_summary_card.dart';
import '../widgets/mood_calendar.dart';
import '../widgets/positive_message_banner.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/emotion_pie_chart_widget.dart';
import '../widgets/mood_pattern_graph.dart';
import '../widgets/ai_suggestion_card.dart';
import '../../home/services/mood_service.dart';
import '../../../core/services/ai_mood_service.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Initial Mock Data to prevent empty state flicker
  Map<String, int> _emotionDistribution = {
    'Happy': 35,
    'Good': 25,
    'Calm': 20,
    'Anxious': 15,
    'Sad': 5,
  };
  
  List<Map<String, dynamic>> _moodHistory = [
    {'mood': 'Happy', 'timestamp': DateTime.now().subtract(const Duration(hours: 2))},
    {'mood': 'Good', 'timestamp': DateTime.now().subtract(const Duration(days: 1))},
    {'mood': 'Calm', 'timestamp': DateTime.now().subtract(const Duration(days: 2))},
    {'mood': 'Anxious', 'timestamp': DateTime.now().subtract(const Duration(days: 3))},
    {'mood': 'Happy', 'timestamp': DateTime.now().subtract(const Duration(days: 4))},
    {'mood': 'Good', 'timestamp': DateTime.now().subtract(const Duration(days: 5))},
    {'mood': 'Calm', 'timestamp': DateTime.now().subtract(const Duration(days: 6))},
  ];

  Map<String, String> _aiSuggestion = {
    'title': 'Finding Balance',
    'description': 'Your positive streaks are great! Keep maintaining your calm moments.',
    'action': 'Try a 10-minute mindfulness walk today.',
  };
  
  bool _isLoadingMoodData = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardProvider.notifier).loadDashboardData('current-user-id');
      _loadMoodData();
    });
  }

  Future<void> _loadMoodData() async {
    setState(() => _isLoadingMoodData = true);
    
    try {
      final moodService = MoodService();
      final aiService = AiMoodService(moodService);
      
      final distribution = await moodService.getEmotionDistribution(days: 30);
      final history = await moodService.getMoodHistory(days: 7);
      
      // Attempt to get real AI suggestion, fallback to static if fails/empty
      Map<String, String> suggestion = _aiSuggestion; 
      try {
         suggestion = await aiService.generateMoodSuggestion();
         // If AI returns generic fallback, keep using our rich mock if available? 
         // For now, trust the service's fallback logic.
      } catch (_) {
         // Keep default mock suggestion on error
      }
      
      if (mounted) {
        setState(() {
          // Only overwrite if we got actual data (or the service mock returned something valid)
          if (distribution.isNotEmpty) _emotionDistribution = distribution;
          if (history.isNotEmpty) _moodHistory = history;
          if (suggestion.isNotEmpty) _aiSuggestion = suggestion;
          
          _isLoadingMoodData = false;
        });
      }
    } catch (e) {
      debugPrint('Dashboard data load error: $e');
      if (mounted) setState(() => _isLoadingMoodData = false);
      // Keep using the initial mock data
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    // Ensure we have a valid score for display (Mock it if 0)
    final double displayScore = state.overallScore > 0 ? state.overallScore : 78.0;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(dashboardProvider.notifier).loadDashboardData('user_id');
          await _loadMoodData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Allow refresh even if content fits
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dashboard Header
              FadeInUp(
                delay: const Duration(milliseconds: 50),
                child: DashboardHeader(
                  mentalHealthScore: displayScore,
                  userName: 'User',
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Positive Message Banner
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      child: PositiveMessageBanner(
                        message: state.positiveMessage.isNotEmpty 
                            ? state.positiveMessage 
                            : "Every small step counts towards your big journey.",
                        onRefresh: () => ref.read(dashboardProvider.notifier).refreshPositiveMessage(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // AI Mood Suggestion
                    if (_aiSuggestion.isNotEmpty)
                      FadeInUp(
                        delay: const Duration(milliseconds: 150),
                        child: AiSuggestionCard(
                          title: _aiSuggestion['title'] ?? '',
                          description: _aiSuggestion['description'] ?? '',
                          action: _aiSuggestion['action'] ?? '',
                          onTryThis: () {
                            // TODO: Implement action handler
                          },
                        ),
                      ),
                    if (_aiSuggestion.isNotEmpty) const SizedBox(height: 24),

                    // Emotional Distribution Pie Chart
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: EmotionPieChartWidget(
                        emotionDistribution: _emotionDistribution,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mood Pattern Line Graph
                    FadeInUp(
                      delay: const Duration(milliseconds: 250),
                      child: MoodPatternGraph(
                        moodHistory: _moodHistory,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Emotional Analysis (Original)
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: const EmotionalAnalysis(),
                    ),
                    const SizedBox(height: 24),

                    // Calendar (New Design)
                    FadeInUp(
                      delay: const Duration(milliseconds: 350),
                      child: const MoodCalendar(),
                    ),
                    const SizedBox(height: 24),

                    // Behavior Patterns
                    if (state.pattern != null && state.pattern!.mostActiveTimeOfDay == 'night') 
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: BehaviorPatternCard(
                           title: "Evening Anxiety Detected",
                           description: "You tend to feel more anxious in the evenings (after 8 PM).",
                           suggestion: "Try a 5-minute wind-down meditation before bed.",
                           actionLabel: "Start Meditation",
                           onAction: () {},
                        ),
                      ),
                     
                    if (state.insights.isNotEmpty) ...[ 
                       const SizedBox(height: 24),
                       FadeInUp(
                         delay: const Duration(milliseconds: 450),
                         child: Text("Insights", style: AppTextStyles.h4),
                       ),
                       const SizedBox(height: 12),
                       ...state.insights.asMap().entries.map((entry) => FadeInUp(
                         delay: Duration(milliseconds: 500 + (entry.key * 50)),
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 12),
                           child: InsightCard(
                             insight: entry.value,
                             onDismiss: () => ref.read(dashboardProvider.notifier).dismissInsight(entry.value.id),
                           ),
                         ),
                       )),
                    ],

                    const SizedBox(height: 24),

                    // Weekly Summary
                    FadeInUp(
                      delay: const Duration(milliseconds: 550),
                      child: WeeklySummaryCard(stats: state.weeklyStats),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Full Report Button
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPink,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("View Full Mental Health Report"),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
