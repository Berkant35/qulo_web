import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_model.dart';
import 'api_provider.dart';

class UserNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async => null;

  Future<void> fetchMe() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userRepositoryProvider).getMe());
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final repo = ref.read(userRepositoryProvider);
    final updated = await repo.updateProfile(data);
    state = AsyncData(updated);
  }

  Future<void> updateDetails(Map<String, dynamic> data) async {
    final repo = ref.read(userRepositoryProvider);
    await repo.updateDetails(data);
    await fetchMe();
  }

  Future<void> updateLocation({required double lat, required double lng}) async {
    final repo = ref.read(userRepositoryProvider);
    await repo.updateLocation(lat: lat, lng: lng);
  }

  Future<void> updatePushToken(String token) async {
    final repo = ref.read(userRepositoryProvider);
    await repo.updatePushToken(token);
  }

  Future<Map<String, dynamic>> uploadPhoto(dynamic bytes, String mimeType) async {
    final repo = ref.read(userRepositoryProvider);
    final result = await repo.uploadPhoto(bytes, mimeType);
    await fetchMe();
    return result;
  }

  Future<void> deletePhoto(int index) async {
    final repo = ref.read(userRepositoryProvider);
    await repo.deletePhoto(index);
    await fetchMe();
  }

  Future<Map<String, dynamic>> boost() async {
    final repo = ref.read(userRepositoryProvider);
    final result = await repo.boost();
    await fetchMe();
    return result;
  }

  Future<void> deleteAccount() async {
    final repo = ref.read(userRepositoryProvider);
    await repo.deleteAccount();
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, UserModel?>(UserNotifier.new);
