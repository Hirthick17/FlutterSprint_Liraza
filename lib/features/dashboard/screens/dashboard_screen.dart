import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/dashboard_models.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/positive_message_banner.dart';
import '../widgets/mental_health_score_widget.dart';
import '../widgets/mood_trend_chart.dart';
import '../widgets/emotion_pie_chart.dart';
import '../widgets/insight_card.dart';
import '../widgets/behavior_pattern_card.dart';
import '../widgets/weekly_summary_card.dart';

import 'package:shimmer/shimmer.dart';
import '../../../core/widgets/fade_in_up.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load data on init
    Future.microtask(() => ref.read(dashboardProvider.notifier).loadDashboardData('user_id'));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
             children: [
               _buildAppBar(),
               Expanded(
                 child: state.isLoading 
                    ? _buildLoadingSkeleton()
                    : _buildContent(state),
               ),
             ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 24),
              Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 24),
              Container(height: 200, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 24),
              Container(height: 200, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dashboard',
            style: AppTextStyles.h2.copyWith(color: Colors.white),
          ),
          Container(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.2),
               borderRadius: BorderRadius.circular(20),
             ),
             child: Row(
               children: [
                 Text('This Week', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
                 const SizedBox(width: 4),
                 const Icon(Icons.arrow_drop_down, color: Colors.white),
               ],
             ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DashboardState state) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () => ref.read(dashboardProvider.notifier).loadDashboardData('user_id'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Positive Message Banner
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: PositiveMessageBanner(
                  message: state.positiveMessage,
                  onRefresh: () => ref.read(dashboardProvider.notifier).refreshPositiveMessage(),
                ),
              ),
              const SizedBox(height: 24),

              // Mental Health Score
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: MentalHealthScoreWidget(
                  score: state.overallScore,
                  trend: state.pattern?.moodTrend ?? 'stable',
                ),
              ),
              const SizedBox(height: 24),

              // Mood Trend Chart
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                     color: AppColors.cardBackground,
                     borderRadius: BorderRadius.circular(20),
                  ),
                  child: MoodTrendChart(logs: state.moodLogs),
                ),
              ),
              
              const SizedBox(height: 24),

              // Emotion Distribution Pie Chart
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                     color: AppColors.cardBackground,
                     borderRadius: BorderRadius.circular(20),
                  ),
                  child: EmotionPieChart(distribution: state.emotionDistribution),
                ),
              ),
              
              const SizedBox(height: 24),

              // Behavior Patterns
              if (state.pattern != null && state.pattern!.mostActiveTimeOfDay == 'night') 
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
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
                   delay: const Duration(milliseconds: 600),
                   child: Text("Insights", style: AppTextStyles.h4),
                 ),
                 const SizedBox(height: 12),
                 ...state.insights.asMap().entries.map((entry) => FadeInUp(
                   delay: Duration(milliseconds: 700 + (entry.key * 100)),
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
                delay: const Duration(milliseconds: 800),
                child: WeeklySummaryCard(stats: state.weeklyStats),
              ),
              
              const SizedBox(height: 24),
              
              // Full Report Button
              FadeInUp(
                delay: const Duration(milliseconds: 900),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("View Full Mental Health Report"),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
