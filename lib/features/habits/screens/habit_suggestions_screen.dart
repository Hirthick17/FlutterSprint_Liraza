import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class HabitSuggestionsScreen extends ConsumerStatefulWidget {
  const HabitSuggestionsScreen({super.key});

  @override
  ConsumerState<HabitSuggestionsScreen> createState() => _HabitSuggestionsScreenState();
}

class _HabitSuggestionsScreenState extends ConsumerState<HabitSuggestionsScreen> {
  // Mock habit data matching the design
  final List<Map<String, dynamic>> _habits = [
    {
      'title': '5-minute mindful breathing exercise',
      'time': '07:30',
      'frequency': 'daily',
      'description': 'Calms the nervous system and fosters present-moment awareness',
      'icon': Icons.air_rounded,
    },
    {
      'title': '20-minute brisk walk outdoors',
      'time': '12:00',
      'frequency': 'daily',
      'description': 'Reduces stress hormones and improves mood through physical activity',
      'icon': Icons.directions_walk_rounded,
    },
    {
      'title': 'Mindful tea or water break (5 minutes)',
      'time': '15:00',
      'frequency': 'daily',
      'description': 'Grounds you in the present and offers a moment of calm',
      'icon': Icons.local_cafe_rounded,
    },
    {
      'title': '10-minute anxiety journaling/ thought download',
      'time': '17:00',
      'frequency': 'daily',
      'description': 'Helps process worries and gain perspective on anxious thoughts',
      'icon': Icons.edit_note_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        backgroundColor: AppColors.hotPink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'AI Habit Suggestions',
          style: AppTextStyles.h3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightPink.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    habit['icon'] as IconData,
                    color: AppColors.hotPink,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit['title'] as String,
                        style: AppTextStyles.h4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${habit['time']} • ${habit['frequency']}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        habit['description'] as String,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Calendar button
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added "${habit['title']}" to calendar'),
                        backgroundColor: AppColors.success,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.hotPink,
                  ),
                  tooltip: 'Add to Calendar',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
