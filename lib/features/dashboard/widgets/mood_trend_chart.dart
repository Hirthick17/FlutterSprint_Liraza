import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/dashboard_models.dart';

class MoodTrendChart extends StatelessWidget {
  final List<MoodLog> logs;

  const MoodTrendChart({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const Center(child: Text("No data yet"));
    }
    
    // Sort logs by date
    final sortedLogs = List<MoodLog>.from(logs)..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("Mood Trend (Last 7 Days)", style: AppTextStyles.h4),
             // Date selector could go here
          ],
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 2,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: AppColors.divider,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      // Show Day Names for last 7 points
                      // This needs careful mapping if points aren't consecutive days. 
                      // For simplicity, assuming daily logs or showing indexed labels
                      if (value.toInt() >= 0 && value.toInt() < sortedLogs.length) {
                         // get abbreviation of day
                         // Assuming logs are last 7 days
                         final date = sortedLogs[value.toInt()].timestamp;
                         final dayName = _getDayName(date.weekday);
                         return SideTitleWidget(
                           axisSide: meta.axisSide,
                           child: Text(dayName, style: AppTextStyles.caption),
                         );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 2,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toInt().toString(), style: AppTextStyles.caption);
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              minX: 0,
              maxX: (sortedLogs.length - 1).toDouble(),
              minY: 0,
              maxY: 10,
              lineBarsData: [
                LineChartBarData(
                  spots: sortedLogs.asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), e.value.score.toDouble());
                  }).toList(),
                  isCurved: true,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      AppColors.primaryPink,
                      AppColors.primaryMagenta,
                    ],
                  ),
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.1),
                        AppColors.primaryPink.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
