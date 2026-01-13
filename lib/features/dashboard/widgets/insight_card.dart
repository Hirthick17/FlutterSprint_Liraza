import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/dashboard_models.dart';

class InsightCard extends StatelessWidget {
  final Insight insight;
  final VoidCallback onDismiss;

  const InsightCard({super.key, required this.insight, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    IconData icon;
    
    switch (insight.type) {
      case InsightType.achievement:
        cardColor = Colors.purple.shade50;
        icon = Icons.emoji_events;
        break;
      case InsightType.warning:
        cardColor = Colors.orange.shade50;
        icon = Icons.warning_rounded;
        break;
      case InsightType.tip:
        cardColor = Colors.blue.shade50;
        icon = Icons.lightbulb;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryPink, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      insight.title,
                      style: AppTextStyles.h4.copyWith(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      color: AppColors.textHint,
                      onPressed: onDismiss,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  insight.message,
                  style: AppTextStyles.bodyMedium,
                ),
                if (insight.actionable) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: insight.onAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryPink),
                      ),
                      child: Text(
                        insight.actionText ?? 'Action',
                        style: AppTextStyles.buttonSmall.copyWith(color: AppColors.primaryPink),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
