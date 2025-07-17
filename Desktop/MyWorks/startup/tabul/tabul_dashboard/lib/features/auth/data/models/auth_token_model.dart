import '../../domain/entities/entities.dart';

/// Auth token model with JSON serialization
/// API response ve cache için kullanılan token modeli
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
    super.tokenType,
    super.expiresIn,
  });

  /// JSON'dan model oluştur
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresIn: json['expires_in'] as int?,
    );
  }

  /// Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }

  /// Entity'den model oluştur
  factory AuthTokenModel.fromEntity(AuthToken token) {
    return AuthTokenModel(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      tokenType: token.tokenType,
      expiresIn: token.expiresIn,
    );
  }
}
