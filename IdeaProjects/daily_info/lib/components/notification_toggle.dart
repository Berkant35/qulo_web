import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../services/notification_service.dart';
import '../services/analytics_service.dart';
import 'app_card.dart';

/// Notification on/off toggle component
class NotificationToggle extends StatefulWidget {
  const NotificationToggle({super.key});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = NotificationService.isNotificationEnabled();
  }

  Future<void> _toggleNotification(bool value) async {
    setState(() {
      _isEnabled = value;
    });
    await NotificationService.toggleNotifications(value);
    await AnalyticsService.logNotificationToggle(value);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.yellowTop.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _isEnabled ? Icons.notifications_active : Icons.notifications_off,
              color: AppColors.darkBlueFrame,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Title and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Notifications',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isEnabled
                      ? 'This day in history notifications active'
                      : 'Notifications disabled',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkText.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
          // Switch
          Switch(
            value: _isEnabled,
            onChanged: _toggleNotification,
          ),
        ],
      ),
    );
  }
}
