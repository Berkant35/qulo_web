import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/user_model.dart';
import '../models/user_details_model.dart';

class UserRepository {
  final ApiClient _client;

  UserRepository(this._client);

  Future<UserModel> getMe() async {
    final response = await _client.dio.get(ApiEndpoints.me);
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await _client.dio.patch(ApiEndpoints.me, data: data);
    return UserModel.fromJson(response.data);
  }

  Future<UserDetailsModel> updateDetails(Map<String, dynamic> data) async {
    final response = await _client.dio.patch(ApiEndpoints.meDetails, data: data);
    return UserDetailsModel.fromJson(response.data);
  }

  Future<void> updateLocation({required double lat, required double lng}) async {
    await _client.dio.patch(ApiEndpoints.meLocation, data: {'lat': lat, 'lng': lng});
  }

  Future<void> updatePushToken(String token) async {
    await _client.dio.patch(ApiEndpoints.mePushToken, data: {'push_token': token});
  }

  Future<Map<String, dynamic>> uploadPhoto(Uint8List bytes, String mimeType) async {
    final ext = mimeType == 'image/png' ? 'png' : 'jpg';
    final formData = FormData.fromMap({
      'photo': MultipartFile.fromBytes(bytes, filename: 'photo.$ext', contentType: DioMediaType.parse(mimeType)),
    });
    final response = await _client.dio.post(ApiEndpoints.mePhotos, data: formData);
    return response.data;
  }

  Future<Map<String, dynamic>> deletePhoto(int index) async {
    final response = await _client.dio.delete('${ApiEndpoints.mePhotos}/$index');
    return response.data;
  }

  Future<void> deleteAccount() async {
    await _client.dio.delete(ApiEndpoints.me);
  }

  Future<Map<String, dynamic>> boost() async {
    final response = await _client.dio.post(ApiEndpoints.meBoost);
    return response.data;
  }
}
