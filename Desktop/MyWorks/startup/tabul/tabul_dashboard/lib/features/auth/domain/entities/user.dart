/// User domain entity
/// Backend API response'una uygun user modeli
class User {
  final int id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// User'ın admin olup olmadığını kontrol et
  bool get isAdminUser => isAdmin;

  /// User'ın aktif olup olmadığını kontrol et
  bool get isActiveUser => isActive;

  /// User'ın görünen adı (UI için)
  String get displayName => username;

  /// User role string (UI için)
  String get roleString => isAdmin ? 'Admin' : 'User';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.isAdmin == isAdmin &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      username,
      email,
      isAdmin,
      isActive,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, isAdmin: $isAdmin, isActive: $isActive)';
  }

  /// Copy with method
  User copyWith({
    int? id,
    String? username,
    String? email,
    bool? isAdmin,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
