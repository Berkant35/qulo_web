import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/models.dart';

/// Auth remote data source abstract class
abstract class AuthRemoteDataSource {
  // Authentication methods
  Future<AuthTokenModel> login(LoginRequestModel request);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  Future<AuthTokenModel> refreshToken(String refreshToken);

  // User management methods
  Future<UserModel> createAdmin(CreateAdminRequestModel request);
  Future<UserModel> createQuickAdmin();
  Future<UserModel> registerUser(RegisterRequestModel request);
  Future<List<UserModel>> getAllAdmins();
  Future<UserModel> getUserByUsername(String username);
}

/// Auth remote data source implementation
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthTokenModel> login(LoginRequestModel request) async {
    try {
      final response = await dioClient.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthTokenModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dioClient.post('/auth/logout');
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dioClient.get('/auth/me');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Get user failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<AuthTokenModel> refreshToken(String refreshToken) async {
    try {
      final response = await dioClient.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        return AuthTokenModel.fromJson(response.data);
      } else {
        throw Exception('Token refresh failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // ==================== USER MANAGEMENT METHODS ====================

  @override
  Future<UserModel> createAdmin(CreateAdminRequestModel request) async {
    try {
      final response = await dioClient.post(
        '/users/create-admin',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        // Backend response format: { "success": true, "data": UserDto, ... }
        final userData = response.data['data'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Create admin failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> createQuickAdmin() async {
    try {
      final response = await dioClient.post('/users/quick-admin');

      if (response.statusCode == 201) {
        // Backend response format: { "success": true, "data": UserDto, ... }
        final userData = response.data['data'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Create quick admin failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> registerUser(RegisterRequestModel request) async {
    try {
      final response = await dioClient.post(
        '/users/register',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        // Backend response format: { "success": true, "data": UserDto, ... }
        final userData = response.data['data'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Register user failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<UserModel>> getAllAdmins() async {
    try {
      final response = await dioClient.get('/users/admins');

      if (response.statusCode == 200) {
        // Backend response format: { "success": true, "data": [UserDto], ... }
        final usersData = response.data['data'] as List<dynamic>;
        return usersData
            .map((userData) =>
                UserModel.fromJson(userData as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Get admins failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> getUserByUsername(String username) async {
    try {
      final response = await dioClient.get('/users/username/$username');

      if (response.statusCode == 200) {
        // Backend response format: { "success": true, "data": UserDto, ... }
        final userData = response.data['data'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        throw Exception(
            'Get user by username failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
