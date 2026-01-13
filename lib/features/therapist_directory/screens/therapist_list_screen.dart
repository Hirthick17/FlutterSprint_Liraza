import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class TherapistListScreen extends StatelessWidget {
  const TherapistListScreen({super.key});

  final List<Map<String, dynamic>> _therapists = const [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Anxiety & Depression',
      'location': 'New York, NY',
      'rating': 4.9,
      'googleMapLink': 'https://maps.google.com/?q=New+York,+NY',
      'googleMeetLink': 'https://meet.google.com/abc-defg-hij',
    },
    {
      'name': 'Dr. Rajesh Kumar',
      'specialty': 'Stress Management',
      'location': 'Mumbai, India',
      'rating': 4.8,
      'googleMapLink': 'https://maps.google.com/?q=Mumbai,+India',
      'googleMeetLink': 'https://meet.google.com/klm-nopq-rst',
    },
    {
      'name': 'Dr. Emily Chen',
      'specialty': 'Relationship Counseling',
      'location': 'San Francisco, CA',
      'rating': 4.7,
      'googleMapLink': 'https://maps.google.com/?q=San+Francisco,+CA',
      'googleMeetLink': 'https://meet.google.com/uvw-xyz-123',
    },
    {
      'name': 'Dr. Michael Brown',
      'specialty': 'Trauma Therapy',
      'location': 'London, UK',
      'rating': 4.9,
      'googleMapLink': 'https://maps.google.com/?q=London,+UK',
      'googleMeetLink': 'https://meet.google.com/456-789-000',
    },
  ];

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        title: Text(
          'Find a Therapist',
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _therapists.length,
        itemBuilder: (context, index) {
          final therapist = _therapists[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.softPink,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.hotPink.withOpacity(0.3), width: 2),
                      ),
                      child: Center(
                         child: Text(
                           therapist['name'][0],
                           style: AppTextStyles.h2.copyWith(color: AppColors.hotPink),
                         ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(therapist['name'], style: AppTextStyles.h4),
                          const SizedBox(height: 4),
                          Text(
                            therapist['specialty'],
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.hotPink),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                therapist['location'],
                                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                              ),
                              const Spacer(),
                              const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                              Text(
                                therapist['rating'].toString(),
                                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.map_rounded,
                        label: 'Locate',
                        color: Colors.blue,
                        onTap: () => _launchUrl(therapist['googleMapLink']),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.video_camera_front_rounded,
                        label: 'Connect',
                        color: Colors.green,
                        onTap: () => _launchUrl(therapist['googleMeetLink']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.button.copyWith(
                  color: color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
