import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class MoodPatternGraph extends StatelessWidget {
  final List<Map<String, dynamic>> moodHistory;

  const MoodPatternGraph({
    super.key,
    required this.moodHistory,
  });

  @override
  Widget build(BuildContext context) {
    if (moodHistory.isEmpty) {
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
              const Icon(Icons.show_chart_rounded, color: AppColors.primaryPink),
              const SizedBox(width: 8),
              Text(
                'Mood Pattern (Last 7 Days)',
                style: AppTextStyles.h4,
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.lightGray,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return _buildBottomTitle(value.toInt());
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return _buildLeftTitle(value.toInt());
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 5,
                lineBarsData: [
                  LineChartBarData(
                    spots: _buildSpots(),
                    isCurved: true,
                    gradient: AppColors.primaryGradient,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppColors.hotPink,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.hotPink.withOpacity(0.3),
                          AppColors.hotPink.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final mood = _getMoodLabel(spot.y.toInt());
                        return LineTooltipItem(
                          mood,
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _buildSpots() {
    // Take last 7 days
    final last7Days = moodHistory.take(7).toList().reversed.toList();
    
    return List.generate(last7Days.length, (index) {
      final mood = last7Days[index]['mood'] as String;
      final moodValue = _moodToValue(mood);
      return FlSpot(index.toDouble(), moodValue);
    });
  }

  double _moodToValue(String mood) {
    switch (mood) {
      case 'Happy':
        return 5.0;
      case 'Good':
        return 4.0;
      case 'Okay':
        return 3.0;
      case 'Low':
        return 2.0;
      case 'Sad':
        return 1.0;
      default:
        return 3.0;
    }
  }

  String _getMoodLabel(int value) {
    switch (value) {
      case 5:
        return '😊 Happy';
      case 4:
        return '🙂 Good';
      case 3:
        return '😐 Okay';
      case 2:
        return '😔 Low';
      case 1:
        return '😢 Sad';
      default:
        return '😐 Okay';
    }
  }

  Widget _buildBottomTitle(int value) {
    final daysAgo = 6 - value;
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        weekDays[date.weekday - 1],
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildLeftTitle(int value) {
    if (value == 0 || value > 5) return const SizedBox.shrink();
    
    final emojis = ['', '😢', '😔', '😐', '🙂', '😊'];
    
    return Text(
      emojis[value],
      style: const TextStyle(fontSize: 16),
    );
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
            Icons.show_chart_rounded,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            'No mood pattern yet',
            style: AppTextStyles.h4.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Log your moods daily to see patterns',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
