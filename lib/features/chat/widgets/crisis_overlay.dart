import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CrisisOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  const CrisisOverlay({super.key, required this.onDismiss});

  Future<void> _callHelpline(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Full screen takeover
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.favorite, color: AppColors.error, size: 64),
              const SizedBox(height: 24),
              Text(
                'We are here for you.',
                style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'It sounds like you\u0027re going through a very difficult time. Please reach out to someone who can help right now.',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Helplines
              ...AppConstants.crisisHelplines.entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () => _callHelpline(e.value),
                  icon: const Icon(Icons.phone),
                  label: Text('Call ${e.key}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              )),

              const Spacer(),
              TextButton(
                onPressed: onDismiss,
                child: Text(
                  'I\u0027m safe now, return to chat',
                  style: AppTextStyles.button.copyWith(color: AppColors.textHint),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
