import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class EmotionPieChartWidget extends StatelessWidget {
  final Map<String, int> emotionDistribution;

  const EmotionPieChartWidget({
    super.key,
    required this.emotionDistribution,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total for percentages
    final total = emotionDistribution.values.fold<int>(0, (sum, value) => sum + value);
    
    if (total == 0) {
      return _buildEmptyState();
    }

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
              const Icon(Icons.pie_chart_rounded, color: AppColors.primaryPink),
              const SizedBox(width: 8),
              Text(
                'Emotional Distribution',
                style: AppTextStyles.h4,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: _buildPieSections(total),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildLegend(total),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections(int total) {
    final emotionColors = {
      'Happy': const Color(0xFFFFD700),
      'Good': const Color(0xFF4CAF50),
      'Okay': Colors.grey,
      'Low': const Color(0xFF9FA8DA),
      'Sad': const Color(0xFFF44336),
    };

    return emotionDistribution.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      final color = emotionColors[entry.key] ?? AppColors.textSecondary;
      
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${percentage.toStringAsFixed(0)}%',
        color: color,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<Widget> _buildLegend(int total) {
    final emotionEmojis = {
      'Happy': '😊',
      'Good': '🙂',
      'Okay': '😐',
      'Low': '😔',
      'Sad': '😢',
    };

    final emotionColors = {
      'Happy': const Color(0xFFFFD700),
      'Good': const Color(0xFF4CAF50),
      'Okay': Colors.grey,
      'Low': const Color(0xFF9FA8DA),
      'Sad': const Color(0xFFF44336),
    };

    return emotionDistribution.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      final emoji = emotionEmojis[entry.key] ?? '😐';
      final color = emotionColors[entry.key] ?? AppColors.textSecondary;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                entry.key,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildEmptyState() {
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
          const Icon(
            Icons.pie_chart_outline_rounded,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            'No mood data yet',
            style: AppTextStyles.h4.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Start logging your moods to see distribution',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
