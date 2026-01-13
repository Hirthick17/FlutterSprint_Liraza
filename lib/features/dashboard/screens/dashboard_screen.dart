import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Mental Health Dashboard',
                  style: AppTextStyles.h2,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Positive Message Banner
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Text('💜', style: TextStyle(fontSize: 32)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'You\'ve shown resilience this week - proud of you!',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Overall Score
                        Container(
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
                              const SizedBox(height: 16),
                              Text(
                                '7.2',
                                style: AppTextStyles.moodScore.copyWith(
                                  color: AppColors.primaryPink,
                                ),
                              ),
                              Text(
                                'out of 10',
                                style: AppTextStyles.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.trending_up,
                                    color: AppColors.success,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '↑ 0.8 from last week',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Stats Grid
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.chat_bubble_rounded,
                                value: '12',
                                label: 'Chat Sessions',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.local_fire_department_rounded,
                                value: '5',
                                label: 'Day Streak',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryPink, size: 32),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
