import '../../domain/entities/entities.dart';

/// Register request model
/// Backend API'ye gönderilecek user kayıt request'i
class RegisterRequestModel {
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  const RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false,
  });

  /// Domain entity'den model oluştur
  factory RegisterRequestModel.fromEntity(RegisterRequest entity) {
    return RegisterRequestModel(
      username: entity.username,
      email: entity.email,
      password: entity.password,
      isAdmin: entity.isAdmin,
    );
  }

  /// Model'i JSON'a çevir (Backend API'ye gönderim için)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  /// JSON'dan model oluştur
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }

  /// Domain entity'ye dönüştür
  RegisterRequest toEntity() {
    return RegisterRequest(
      username: username,
      email: email,
      password: password,
      isAdmin: isAdmin,
    );
  }

  @override
  String toString() {
    return 'RegisterRequestModel(username: $username, email: $email, isAdmin: $isAdmin)';
  }
}
