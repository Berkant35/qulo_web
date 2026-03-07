import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/auth_model.dart';

class AuthRepository {
  final ApiClient _client;

  AuthRepository(this._client);

  Future<RegisterResponse> register({
    required String email,
    required String password,
    required String name,
    required String surname,
    required int age,
    required String gender,
    String locale = 'tr',
  }) async {
    final response = await _client.dio.post(ApiEndpoints.register, data: {
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'age': age,
      'gender': gender,
      'locale': locale,
    });
    return RegisterResponse.fromJson(response.data);
  }

  Future<AuthTokens> login({required String email, required String password}) async {
    final response = await _client.dio.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
    return AuthTokens.fromJson(response.data);
  }

  Future<void> verifyEmail(String token) async {
    await _client.dio.post(ApiEndpoints.verifyEmail, data: {'token': token});
  }

  Future<RefreshResponse> refresh(String refreshToken) async {
    final response = await _client.dio.post(ApiEndpoints.refresh, data: {
      'refreshToken': refreshToken,
    });
    return RefreshResponse.fromJson(response.data);
  }

  Future<void> logout({String? refreshToken}) async {
    await _client.dio.post(ApiEndpoints.logout, data: {
      if (refreshToken != null) 'refreshToken': refreshToken,
    });
  }

  Future<void> forgotPassword(String email) async {
    await _client.dio.post(ApiEndpoints.forgotPassword, data: {'email': email});
  }

  Future<void> resetPassword({required String token, required String password}) async {
    await _client.dio.post(ApiEndpoints.resetPassword, data: {
      'token': token,
      'password': password,
    });
  }
}
