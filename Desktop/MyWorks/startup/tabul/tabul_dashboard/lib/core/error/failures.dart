import 'package:equatable/equatable.dart';

/// Base failure class
/// Tüm hata türleri için temel sınıf
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

/// Server failure
/// API ve sunucu hataları için
class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailure('Geçersiz istek');
      case 401:
        return const ServerFailure('Yetkisiz erişim');
      case 403:
        return const ServerFailure('Erişim yasak');
      case 404:
        return const ServerFailure('Bulunamadı');
      case 408:
        return const ServerFailure('İstek zaman aşımı');
      case 429:
        return const ServerFailure('Çok fazla istek');
      case 500:
        return const ServerFailure('Sunucu hatası');
      case 502:
        return const ServerFailure('Bad Gateway');
      case 503:
        return const ServerFailure('Hizmet kullanılamıyor');
      case 504:
        return const ServerFailure('Gateway timeout');
      default:
        return const ServerFailure('Bilinmeyen sunucu hatası');
    }
  }
}

/// Network failure
/// İnternet bağlantısı ve network hataları için
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  factory NetworkFailure.noConnection() {
    return const NetworkFailure('İnternet bağlantınızı kontrol edin');
  }

  factory NetworkFailure.timeout() {
    return const NetworkFailure('Bağlantı zaman aşımına uğradı');
  }

  factory NetworkFailure.unknown() {
    return const NetworkFailure('Bilinmeyen network hatası');
  }
}

/// Cache failure
/// Yerel cache hataları için
class CacheFailure extends Failure {
  const CacheFailure(super.message);

  factory CacheFailure.read() {
    return const CacheFailure('Cache verisi okunamadı');
  }

  factory CacheFailure.write() {
    return const CacheFailure('Cache verisi yazılamadı');
  }

  factory CacheFailure.notFound() {
    return const CacheFailure('Cache verisi bulunamadı');
  }

  factory CacheFailure.expired() {
    return const CacheFailure('Cache verisi süresi dolmuş');
  }
}

/// Validation failure
/// Form validation hataları için
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);

  factory ValidationFailure.email() {
    return const ValidationFailure('Geçerli bir email adresi girin');
  }

  factory ValidationFailure.password() {
    return const ValidationFailure('Şifre en az 8 karakter olmalı');
  }

  factory ValidationFailure.required(String field) {
    return ValidationFailure('$field alanı zorunludur');
  }

  factory ValidationFailure.minLength(String field, int minLength) {
    return ValidationFailure('$field en az $minLength karakter olmalı');
  }

  factory ValidationFailure.maxLength(String field, int maxLength) {
    return ValidationFailure('$field en fazla $maxLength karakter olabilir');
  }
}

/// Authentication failure
/// Giriş ve kimlik doğrulama hataları için
class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure('Email veya şifre hatalı');
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure('Kullanıcı bulunamadı');
  }

  factory AuthFailure.accountDisabled() {
    return const AuthFailure('Hesabınız devre dışı bırakılmış');
  }

  factory AuthFailure.tokenExpired() {
    return const AuthFailure('Oturum süreniz dolmuş');
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure('Şifre çok zayıf');
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure('Bu email adresi zaten kullanımda');
  }
}

/// Permission failure
/// Yetkilendirme hataları için
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);

  factory PermissionFailure.denied() {
    return const PermissionFailure('Bu işlem için yetkiniz bulunmuyor');
  }

  factory PermissionFailure.storage() {
    return const PermissionFailure('Depolama izni gerekli');
  }

  factory PermissionFailure.camera() {
    return const PermissionFailure('Kamera izni gerekli');
  }

  factory PermissionFailure.location() {
    return const PermissionFailure('Konum izni gerekli');
  }
}

/// Parse failure
/// JSON parsing ve data conversion hataları için
class ParseFailure extends Failure {
  const ParseFailure(super.message);

  factory ParseFailure.json() {
    return const ParseFailure('JSON verisi işlenemedi');
  }

  factory ParseFailure.format() {
    return const ParseFailure('Veri formatı geçersiz');
  }

  factory ParseFailure.missingField(String field) {
    return ParseFailure('Gerekli alan eksik: $field');
  }
}

/// File failure
/// Dosya işlem hataları için
class FileFailure extends Failure {
  const FileFailure(super.message);

  factory FileFailure.notFound() {
    return const FileFailure('Dosya bulunamadı');
  }

  factory FileFailure.readError() {
    return const FileFailure('Dosya okunamadı');
  }

  factory FileFailure.writeError() {
    return const FileFailure('Dosya yazılamadı');
  }

  factory FileFailure.tooLarge() {
    return const FileFailure('Dosya boyutu çok büyük');
  }

  factory FileFailure.invalidFormat() {
    return const FileFailure('Geçersiz dosya formatı');
  }
}

/// Generic failure
/// Genel hata durumları için
class GenericFailure extends Failure {
  const GenericFailure(super.message);

  factory GenericFailure.unknown() {
    return const GenericFailure('Bilinmeyen bir hata oluştu');
  }

  factory GenericFailure.custom(String message) {
    return GenericFailure(message);
  }
}
