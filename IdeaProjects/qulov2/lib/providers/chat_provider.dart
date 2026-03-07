import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/message_model.dart';
import 'api_provider.dart';

class ChatNotifier extends FamilyAsyncNotifier<ChatState, String> {
  @override
  Future<ChatState> build(String matchId) async {
    return const ChatState();
  }

  Future<void> loadMessages({int page = 1}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(chatRepositoryProvider);
      final response = await repo.getMessages(arg, page: page);
      return ChatState(
        messages: response.messages,
        total: response.total,
        page: response.page,
      );
    });
  }

  Future<void> sendMessage(String content, {bool isImage = false}) async {
    final repo = ref.read(chatRepositoryProvider);
    final message = await repo.sendMessage(arg, content: content, isImage: isImage);
    final current = state.valueOrNull ?? const ChatState();
    state = AsyncData(current.copyWith(
      messages: [message, ...current.messages],
      total: current.total + 1,
    ));
  }

  Future<void> markAsRead() async {
    final repo = ref.read(chatRepositoryProvider);
    await repo.markAsRead(arg);
  }

  void addRealtimeMessage(MessageModel message) {
    final current = state.valueOrNull ?? const ChatState();
    state = AsyncData(current.copyWith(
      messages: [message, ...current.messages],
      total: current.total + 1,
    ));
  }
}

class ChatState {
  final List<MessageModel> messages;
  final int total;
  final int page;

  const ChatState({this.messages = const [], this.total = 0, this.page = 1});

  ChatState copyWith({List<MessageModel>? messages, int? total, int? page}) {
    return ChatState(
      messages: messages ?? this.messages,
      total: total ?? this.total,
      page: page ?? this.page,
    );
  }
}

final chatProvider = AsyncNotifierProvider.family<ChatNotifier, ChatState, String>(ChatNotifier.new);
