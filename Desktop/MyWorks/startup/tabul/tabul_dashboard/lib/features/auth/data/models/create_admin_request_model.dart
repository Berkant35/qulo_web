import '../../domain/entities/entities.dart';

/// Create admin request model
/// Backend API'ye gönderilecek admin oluşturma request'i
class CreateAdminRequestModel {
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  const CreateAdminRequestModel({
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = true,
  });

  /// Domain entity'den model oluştur
  factory CreateAdminRequestModel.fromEntity(CreateAdminRequest entity) {
    return CreateAdminRequestModel(
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
  factory CreateAdminRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateAdminRequestModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool? ?? true,
    );
  }

  /// Domain entity'ye dönüştür
  CreateAdminRequest toEntity() {
    return CreateAdminRequest(
      username: username,
      email: email,
      password: password,
      isAdmin: isAdmin,
    );
  }

  @override
  String toString() {
    return 'CreateAdminRequestModel(username: $username, email: $email, isAdmin: $isAdmin)';
  }
}
