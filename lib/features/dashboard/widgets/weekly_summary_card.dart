import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/dashboard_models.dart';

class WeeklySummaryCard extends StatelessWidget {
  final WeeklyStats stats;

  const WeeklySummaryCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Weekly Summary", style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildStatRow(
            icon: Icons.chat_bubble_outline_rounded,
            label: "Chat Sessions",
            value: stats.totalSessions.toString(),
            color: Colors.blue,
          ),
          const Divider(height: 24),
          _buildStatRow(
            icon: Icons.timer_outlined,
            label: "Avg Session",
            value: "${stats.avgDuration} min",
            color: Colors.orange,
          ),
          const Divider(height: 24),
          _buildStatRow(
            icon: Icons.trending_up_rounded,
            label: "Mood Improvement",
            value: "+${stats.moodImprovement}%",
            color: Colors.green,
          ),
           const Divider(height: 24),
          _buildStatRow(
            icon: Icons.local_fire_department_outlined,
            label: "Current Streak",
            value: "${stats.streak} days",
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(label, style: AppTextStyles.bodyMedium),
        ),
        Text(value, style: AppTextStyles.h4.copyWith(fontSize: 16)),
      ],
    );
  }
}
