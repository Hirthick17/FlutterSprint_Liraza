import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class EmotionPieChart extends StatelessWidget {
  final Map<String, int> distribution;

  const EmotionPieChart({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    if (distribution.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No emotion data yet")),
      );
    }

    final total = distribution.values.fold(0, (sum, val) => sum + val);

    return Column(
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Emotion Distribution", style: AppTextStyles.h4),
           ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    sections: distribution.entries.map((entry) {
                      final percentage = (entry.value / total) * 100;
                      final color = AppColors.getEmotionColor(entry.key);
                      
                      return PieChartSectionData(
                        color: color,
                        value: percentage,
                        title: '${percentage.toInt()}%',
                        radius: 50,
                        titleStyle: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: distribution.entries.map((entry) {
                   final color = AppColors.getEmotionColor(entry.key);
                   return Padding(
                     padding: const EdgeInsets.symmetric(vertical: 4),
                     child: Row(
                       children: [
                         Container(
                           width: 12,
                           height: 12,
                           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                         ),
                         const SizedBox(width: 8),
                         Text(
                           entry.key[0].toUpperCase() + entry.key.substring(1), 
                           style: AppTextStyles.bodySmall
                         ),
                       ],
                     ),
                   );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
