import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class MentalHealthScoreWidget extends StatelessWidget {
  final double score;
  final String trend; // improving, declining, or stable
  
  const MentalHealthScoreWidget({
    super.key,
    required this.score,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on score
    Color scoreColor = AppColors.getMoodColor(score);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Overall Mental Health Score',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: score / 10,
                  strokeWidth: 10,
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toStringAsFixed(1),
                    style: AppTextStyles.moodScore.copyWith(
                      fontSize: 36,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '/10',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
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
                trend == 'improving' ? Icons.trending_up : (trend == 'declining' ? Icons.trending_down : Icons.trending_flat),
                color: trend == 'improving' ? AppColors.success : (trend == 'declining' ? AppColors.error : AppColors.textSecondary),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                trend == 'improving' ? 'Improving from last week' : (trend == 'declining' ? 'Declining from last week' : 'Stable'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: trend == 'improving' ? AppColors.success : (trend == 'declining' ? AppColors.error : AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
