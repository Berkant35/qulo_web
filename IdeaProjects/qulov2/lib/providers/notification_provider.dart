import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/data/models/notification_model.dart';
import 'package:qulo_v2/providers/api_provider.dart';
import 'package:qulo_v2/providers/user_provider.dart';

class NotificationState {
  final List<NotificationModel> notifications;
  final int unreadCount;
  final bool isLoading;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isLoading = false,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    int? unreadCount,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class NotificationNotifier extends Notifier<NotificationState> {
  @override
  NotificationState build() => const NotificationState();

  Future<void> init() async {
    final manager = ref.read(notificationManagerProvider);

    await manager.init();

    // Send token to backend
    final token = manager.token;
    if (token != null) {
      await ref.read(userProvider.notifier).updatePushToken(token);
    }

    // Set callbacks
    manager.setCallbacks(
      onTokenRefresh: (newToken) {
        ref.read(userProvider.notifier).updatePushToken(newToken);
      },
      onForegroundMessage: _handleForegroundMessage,
      onMessageOpenedApp: _handleMessageTap,
    );

    // Check if app was opened via notification from terminated state (one-time)
    final initialMessage = await manager.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageTap(initialMessage);
    }

    // Fetch unread count
    await fetchUnreadCount();
  }

  void _handleForegroundMessage(RemoteMessage message) {
    state = state.copyWith(unreadCount: state.unreadCount + 1);
    _onForegroundNotification?.call(message);
  }

  void _handleMessageTap(RemoteMessage message) {
    final actionUrl = message.data['action_url'] as String?;
    final notificationId = message.data['notification_id'] as String?;

    if (notificationId != null) {
      markAsRead(notificationId);
    }
    if (actionUrl != null && actionUrl.isNotEmpty) {
      _onNavigate?.call(actionUrl);
    }
  }

  // UI callbacks — set by app shell
  void Function(RemoteMessage)? _onForegroundNotification;
  void Function(String actionUrl)? _onNavigate;

  void setUICallbacks({
    void Function(RemoteMessage)? onForegroundNotification,
    void Function(String actionUrl)? onNavigate,
  }) {
    _onForegroundNotification = onForegroundNotification;
    _onNavigate = onNavigate;
  }

  Future<void> fetchNotifications({int page = 1}) async {
    state = state.copyWith(isLoading: true);
    final result =
        await ref.read(notificationRepositoryProvider).getNotifications(page, 20);
    result.when(
      success: (list) {
        final all = page == 1 ? list : [...state.notifications, ...list];
        state = state.copyWith(notifications: all, isLoading: false);
      },
      failure: (_) => state = state.copyWith(isLoading: false),
    );
  }

  Future<void> fetchUnreadCount() async {
    final result =
        await ref.read(notificationRepositoryProvider).getUnreadCount();
    result.when(
      success: (count) => state = state.copyWith(unreadCount: count),
      failure: (_) {},
    );
  }

  Future<void> markAsRead(String id) async {
    await ref.read(notificationRepositoryProvider).markAsRead(id);
    final updated = state.notifications.map((n) {
      if (n.id == id && !n.isRead) {
        return NotificationModel(
          id: n.id,
          userId: n.userId,
          campaignId: n.campaignId,
          type: n.type,
          title: n.title,
          body: n.body,
          imageUrl: n.imageUrl,
          actionUrl: n.actionUrl,
          actionLabel: n.actionLabel,
          isRead: true,
          createdAt: n.createdAt,
        );
      }
      return n;
    }).toList();
    final newUnread = (state.unreadCount - 1).clamp(0, 9999);
    state = state.copyWith(notifications: updated, unreadCount: newUnread);
  }

  Future<void> markAllAsRead() async {
    await ref.read(notificationRepositoryProvider).markAllAsRead();
    final updated = state.notifications
        .map((n) => NotificationModel(
              id: n.id,
              userId: n.userId,
              campaignId: n.campaignId,
              type: n.type,
              title: n.title,
              body: n.body,
              imageUrl: n.imageUrl,
              actionUrl: n.actionUrl,
              actionLabel: n.actionLabel,
              isRead: true,
              createdAt: n.createdAt,
            ))
        .toList();
    state = state.copyWith(notifications: updated, unreadCount: 0);
  }

  Future<void> trackClick(String id) async {
    await ref.read(notificationRepositoryProvider).trackClick(id);
  }
}

final notificationProvider =
    NotifierProvider<NotificationNotifier, NotificationState>(
  NotificationNotifier.new,
);
