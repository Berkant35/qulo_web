import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entities.dart';

/// Auth repository abstract class
/// Authentication ve User management işlemleri için contract
abstract class AuthRepository {
  // ==================== AUTHENTICATION METHODS ====================

  /// Login işlemi
  Future<Either<Failure, AuthToken>> login(LoginRequest request);

  /// Logout işlemi
  Future<Either<Failure, void>> logout();

  /// Current user bilgilerini al
  Future<Either<Failure, User>> getCurrentUser();

  /// Token'ı yenile
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken);

  /// User'ın login olup olmadığını kontrol et
  Future<bool> isLoggedIn();

  /// Stored token'ı al
  Future<String?> getStoredToken();

  /// Token'ı kaydet
  Future<void> saveToken(AuthToken token);

  /// Token'ı temizle
  Future<void> clearToken();

  // ==================== USER MANAGEMENT METHODS ====================

  /// Özel bilgilerle admin oluştur
  Future<Either<Failure, User>> createAdmin(CreateAdminRequest request);

  /// Hızlı admin oluştur (default: admin/dad.153hb)
  Future<Either<Failure, User>> createQuickAdmin();

  /// Yeni user/admin kaydı
  Future<Either<Failure, User>> registerUser(RegisterRequest request);

  /// Tüm admin kullanıcıları listele
  Future<Either<Failure, List<User>>> getAllAdmins();

  /// Username ile kullanıcı ara
  Future<Either<Failure, User>> getUserByUsername(String username);
}
