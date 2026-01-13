import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class TherapistListScreen extends StatelessWidget {
  const TherapistListScreen({super.key});

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
                  'Find a Therapist',
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
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      _TherapistCard(
                        name: 'Dr. Anjali Sharma',
                        specialty: 'Anxiety, Depression',
                        rating: 4.8,
                        reviews: 124,
                        distance: '2.3 km',
                      ),
                      _TherapistCard(
                        name: 'Dr. Rajesh Kumar',
                        specialty: 'Stress Management',
                        rating: 4.9,
                        reviews: 98,
                        distance: '3.1 km',
                      ),
                      _TherapistCard(
                        name: 'Dr. Priya Patel',
                        specialty: 'Relationship Issues',
                        rating: 4.7,
                        reviews: 156,
                        distance: '4.5 km',
                      ),
                    ],
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

class _TherapistCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String distance;

  const _TherapistCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryPink,
            child: Text(
              name[4],
              style: AppTextStyles.h3.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.h4),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('$rating ($reviews reviews)', style: AppTextStyles.caption),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, color: AppColors.primaryPink, size: 16),
                    const SizedBox(width: 4),
                    Text(distance, style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
