import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationSetScreen extends ConsumerStatefulWidget {
  const NotificationSetScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _NotificationSetScreenState();
}

class _NotificationSetScreenState extends ConsumerState<NotificationSetScreen> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  void scheduleNotification(TimeOfDay timeOfDay) async {
    final now = DateTime.now();
    final notificationTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final tzTime = tz.TZDateTime.from(notificationTime, tz.local);

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const darwinPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Formula Egzersizi Hatırlatıcısı',
      '3 Set Formula Egzersizi Yapma Zamanı!',
      tzTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Notification'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            selectedTime != null
                ? 'Selected Time: ${selectedTime!.format(context)}'
                : 'No time selected',
            style: const TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: const Text('Pick Time'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedTime != null) {
                scheduleNotification(selectedTime!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification Scheduled')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a time first')),
                );
              }
            },
            child: const Text('Set Notification'),
          ),
        ],
      ),
    );
  }
}
