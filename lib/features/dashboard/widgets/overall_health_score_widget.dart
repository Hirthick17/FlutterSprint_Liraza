import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class OverallHealthScoreWidget extends StatelessWidget {
  final double score; // 0.0 to 10.0
  final bool isDeclining;

  const OverallHealthScoreWidget({
    super.key,
    required this.score,
    this.isDeclining = true, // Default based on screenshot
  });

  @override
  Widget build(BuildContext context) {
    Color ringColor = _getScoreColor(score);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Overall Mental Health Score',
            style: AppTextStyles.h4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: score / 10,
                  strokeWidth: 15,
                  backgroundColor: AppColors.lightGray,
                  color: ringColor,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toStringAsFixed(1),
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    '/10',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDeclining ? Icons.trending_down : Icons.trending_up,
                color: isDeclining ? AppColors.error : AppColors.success,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                isDeclining ? 'Declining from last week' : 'Improving from last week',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDeclining ? AppColors.error : AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 8) return AppColors.success;
    if (score >= 6) return const Color(0xFF8BC34A); // Light Green
    if (score >= 4) return const Color(0xFFFFD700); // Yellow
    if (score >= 2) return const Color(0xFFFFB347); // Orange
    return AppColors.error;
  }
}
