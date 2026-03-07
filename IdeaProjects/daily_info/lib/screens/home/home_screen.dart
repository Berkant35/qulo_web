import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../components/notification_toggle.dart';
import '../../components/app_card.dart';
import '../../services/analytics_service.dart';

/// Home screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Log screen view
    AnalyticsService.logScreenView('home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome card
              AppCard(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.yellowTop,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history_edu,
                        size: 48,
                        color: AppColors.darkBlueFrame,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This Day in History',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlueFrame,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover important historical events that happened on this day!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkText.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Notification toggle
              const NotificationToggle(),
              const SizedBox(height: 16),
              // Info card
              AppCard(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.darkBlueFrame.withOpacity(0.7),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'When notifications are enabled, you will receive a new historical fact every day.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.darkText.withOpacity(0.7),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
