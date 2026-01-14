import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class EmotionalAnalysis extends StatelessWidget {
  const EmotionalAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pie_chart_outline, color: AppColors.primaryPink),
              const SizedBox(width: 8),
              Text(
                'Emotional Analysis (Last 30 Days)',
                style: AppTextStyles.h4,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _EmotionIndicator(
                emoji: '🤩',
                label: 'Very Happy',
                color: AppColors.primaryPink,
                percentage: 0.15,
                value: '15%',
              ),
              _EmotionIndicator(
                emoji: '😌',
                label: 'Happy',
                color: const Color(0xFFFFD700), // Gold
                percentage: 0.22,
                value: '22%',
              ),
              _EmotionIndicator(
                emoji: '😐',
                label: 'Neutral',
                color: Colors.grey,
                percentage: 0.56,
                value: '56%',
              ),
              _EmotionIndicator(
                emoji: '😔',
                label: 'Sad',
                color: Colors.blueGrey,
                percentage: 0.05,
                value: '5%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmotionIndicator extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  final double percentage;
  final String value;

  const _EmotionIndicator({
    required this.emoji,
    required this.label,
    required this.color,
    required this.percentage,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 6,
                backgroundColor: AppColors.lightGray,
                color: color,
                strokeCap: StrokeCap.round,
              ),
            ),
            Text(emoji, style: const TextStyle(fontSize: 24)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
