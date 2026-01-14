import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class MoodCalendar extends StatelessWidget {
  const MoodCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for the calendar
    final days = List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: 6 - index));
      return date;
    });

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mood Calendar", style: AppTextStyles.h4),
              Icon(Icons.calendar_today_rounded, color: AppColors.textSecondary, size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((date) => _buildDayItem(date)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(DateTime date) {
    final isToday = date.day == DateTime.now().day;
    final weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final weekDay = weekDays[date.weekday - 1];
    
    // Mock mood colors logic
    final moodColors = [
      AppColors.success,
      AppColors.warning,
      AppColors.error,
      AppColors.info,
      AppColors.deepPink,
      AppColors.success,
      AppColors.warning,
    ];
    
    final color = moodColors[date.weekday - 1].withOpacity(0.2);
    final borderColor = moodColors[date.weekday - 1];

    return Column(
      children: [
        Text(
          weekDay,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? AppColors.deepPink : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
