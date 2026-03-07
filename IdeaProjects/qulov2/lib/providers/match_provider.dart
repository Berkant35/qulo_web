import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/discover_model.dart';
import '../data/models/match_model.dart';
import 'api_provider.dart';

class DiscoverNotifier extends AsyncNotifier<DiscoverState> {
  @override
  Future<DiscoverState> build() async => const DiscoverState();

  Future<void> loadCards({int page = 1}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(matchRepositoryProvider);
      final response = await repo.discover(page: page);
      return DiscoverState(
        cards: response.cards,
        page: response.page,
        hasMore: response.hasMore,
      );
    });
  }

  Future<SwipeResponse> swipe({required String targetId, required String action}) async {
    final repo = ref.read(matchRepositoryProvider);
    final result = await repo.swipe(targetId: targetId, action: action);
    final current = state.valueOrNull;
    if (current != null) {
      final updatedCards = current.cards.where((c) => c.userId != targetId).toList();
      state = AsyncData(current.copyWith(cards: updatedCards));
    }
    return result;
  }
}

class DiscoverState {
  final List<ProfileCardModel> cards;
  final int page;
  final bool hasMore;

  const DiscoverState({this.cards = const [], this.page = 1, this.hasMore = false});

  DiscoverState copyWith({List<ProfileCardModel>? cards, int? page, bool? hasMore}) {
    return DiscoverState(
      cards: cards ?? this.cards,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final discoverProvider = AsyncNotifierProvider<DiscoverNotifier, DiscoverState>(DiscoverNotifier.new);

class MatchListNotifier extends AsyncNotifier<List<MatchModel>> {
  @override
  Future<List<MatchModel>> build() async => [];

  Future<void> fetchMatches() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(matchRepositoryProvider).getMatches());
  }

  Future<void> unmatch(String matchId) async {
    final repo = ref.read(matchRepositoryProvider);
    await repo.unmatch(matchId);
    await fetchMatches();
  }
}

final matchListProvider = AsyncNotifierProvider<MatchListNotifier, List<MatchModel>>(MatchListNotifier.new);
