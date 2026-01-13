import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class BehaviorPatternCard extends StatelessWidget {
  final String title;
  final String description;
  final String? suggestion; // actionable suggestion
  final String? actionLabel;
  final VoidCallback? onAction;

  const BehaviorPatternCard({
    super.key,
    required this.title,
    required this.description,
    this.suggestion,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryPink.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               const Icon(Icons.psychology_outlined, color: AppColors.primaryPink),
               const SizedBox(width: 8),
               Text("Pattern Detected", style: AppTextStyles.label.copyWith(color: AppColors.primaryPink)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.h4),
          const SizedBox(height: 8),
          Text(description, style: AppTextStyles.bodyMedium),
          
          if (suggestion != null) ...[
             const SizedBox(height: 16),
             Container(
               padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
                 color: AppColors.cardBackground,
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       const Icon(Icons.lightbulb_outline, size: 16, color: Colors.orange),
                       const SizedBox(width: 8),
                       Text("Suggestion", style: AppTextStyles.label.copyWith(color: Colors.orange)),
                     ],
                   ),
                   const SizedBox(height: 4),
                   Text(suggestion!, style: AppTextStyles.bodySmall),
                   if (actionLabel != null && onAction != null) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: onAction,
                        child: Text(
                          actionLabel!,
                          style: AppTextStyles.buttonSmall.copyWith(color: AppColors.primaryPink),
                        ),
                      ),
                   ],
                 ],
               ),
             ),
          ],
        ],
      ),
    );
  }
}
