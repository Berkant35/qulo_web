import '../../domain/entities/entities.dart';

/// User data model
/// Backend API response'unu parse eden model
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.isAdmin,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Backend API response'undan UserModel oluştur
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      isAdmin: json['isAdmin'] as bool,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// UserModel'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Domain User entity'ye dönüştür
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      isAdmin: isAdmin,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// UserModel'den UserModel oluştur (copy constructor)
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      isAdmin: user.isAdmin,
      isActive: user.isActive,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, isAdmin: $isAdmin, isActive: $isActive)';
  }
}
