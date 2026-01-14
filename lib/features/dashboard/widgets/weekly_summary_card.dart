import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class WeeklySummaryCard extends StatelessWidget {
  final WeeklyStats stats;

  const WeeklySummaryCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Summary",
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(
                label: "Sessions",
                value: stats.totalSessions.toString(),
                icon: Icons.chat_bubble_outline_rounded,
                color: AppColors.info,
              ),
              _buildDivider(),
              _buildStatItem(
                label: "Avg Duration",
                value: "${stats.avgDuration}m",
                icon: Icons.timer_outlined,
                color: AppColors.warning,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(
                label: "Mood Lift",
                value: "+${stats.moodImprovement.toStringAsFixed(0)}%",
                icon: Icons.trending_up_rounded,
                color: AppColors.success,
              ),
              _buildDivider(),
              _buildStatItem(
                label: "Streak",
                value: "${stats.streak} days",
                icon: Icons.local_fire_department_outlined,
                color: AppColors.deepPink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.warmGray,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
