import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/domain.dart';
import '../data_sources/data_sources.dart';
import '../models/models.dart';

/// Auth repository implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthToken>> login(LoginRequest request) async {
    try {
      final requestModel = LoginRequestModel.fromEntity(request);
      final token = await remoteDataSource.login(requestModel);

      // Save token locally
      await localDataSource.saveToken(token);

      return Right(token);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Call remote logout endpoint
      await remoteDataSource.logout();

      // Clear local data
      await localDataSource.clearToken();
      await localDataSource.clearUser();

      return const Right(null);
    } catch (e) {
      // Even if remote logout fails, clear local data
      await localDataSource.clearToken();
      await localDataSource.clearUser();
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get from cache first
      final cachedUser = await localDataSource.getUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }

      // If not in cache, fetch from remote
      final user = await remoteDataSource.getCurrentUser();

      // Save to cache
      await localDataSource.saveUser(user);

      return Right(user);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken) async {
    try {
      final newToken = await remoteDataSource.refreshToken(refreshToken);

      // Save new token
      await localDataSource.saveToken(newToken);

      return Right(newToken);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<String?> getStoredToken() async {
    final token = await localDataSource.getToken();
    return token?.accessToken;
  }

  @override
  Future<void> saveToken(AuthToken token) async {
    final tokenModel = AuthTokenModel.fromEntity(token);
    await localDataSource.saveToken(tokenModel);
  }

  @override
  Future<void> clearToken() async {
    await localDataSource.clearToken();
    await localDataSource.clearUser();
  }

  // ==================== USER MANAGEMENT METHODS ====================

  @override
  Future<Either<Failure, User>> createAdmin(CreateAdminRequest request) async {
    try {
      final requestModel = CreateAdminRequestModel.fromEntity(request);
      final userModel = await remoteDataSource.createAdmin(requestModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, User>> createQuickAdmin() async {
    try {
      final userModel = await remoteDataSource.createQuickAdmin();
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(RegisterRequest request) async {
    try {
      final requestModel = RegisterRequestModel.fromEntity(request);
      final userModel = await remoteDataSource.registerUser(requestModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllAdmins() async {
    try {
      final userModels = await remoteDataSource.getAllAdmins();
      final users = userModels.map((model) => model.toEntity()).toList();
      return Right(users);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, User>> getUserByUsername(String username) async {
    try {
      final userModel = await remoteDataSource.getUserByUsername(username);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  /// Error handling helper
  Failure _handleError(dynamic error) {
    final errorMessage = error.toString();

    if (errorMessage.contains('Network error')) {
      return NetworkFailure.noConnection();
    } else if (errorMessage.contains('timeout')) {
      return NetworkFailure.timeout();
    } else if (errorMessage.contains('401') ||
        errorMessage.contains('unauthorized')) {
      return const AuthFailure('Geçersiz email veya şifre');
    } else if (errorMessage.contains('403') ||
        errorMessage.contains('forbidden')) {
      return const AuthFailure('Bu işlem için yetkiniz bulunmuyor');
    } else if (errorMessage.contains('404')) {
      return const ServerFailure('Kullanıcı bulunamadı');
    } else if (errorMessage.contains('500')) {
      return const ServerFailure('Sunucu hatası oluştu');
    } else {
      return ServerFailure.fromStatusCode(500);
    }
  }
}
