import '../../domain/entities/entities.dart';

/// Login request model with JSON serialization
/// API request için kullanılan model
class LoginRequestModel extends LoginRequest {
  const LoginRequestModel({
    required super.email,
    required super.password,
  });

  /// JSON'dan model oluştur
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  /// Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  /// Entity'den model oluştur
  factory LoginRequestModel.fromEntity(LoginRequest request) {
    return LoginRequestModel(
      email: request.email,
      password: request.password,
    );
  }
}
