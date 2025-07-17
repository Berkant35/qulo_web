/// Register request entity
/// Backend API'ye user/admin kayıt isteği için model
class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  const RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false, // Default normal user
  });

  /// Validation için username kontrolü
  bool get isValidUsername => username.length >= 3 && username.length <= 50;

  /// Validation için email kontrolü
  bool get isValidEmail => email.contains('@') && email.contains('.');

  /// Validation için password kontrolü
  bool get isValidPassword => password.length >= 6;

  /// Tüm validation kontrolü
  bool get isValid => isValidUsername && isValidEmail && isValidPassword;

  /// User type string
  String get userType => isAdmin ? 'Admin' : 'Normal User';

  /// Validation error mesajları
  List<String> get validationErrors {
    List<String> errors = [];

    if (!isValidUsername) {
      errors.add('Kullanıcı adı 3-50 karakter arası olmalı');
    }

    if (!isValidEmail) {
      errors.add('Geçerli bir email adresi giriniz');
    }

    if (!isValidPassword) {
      errors.add('Şifre en az 6 karakter olmalı');
    }

    return errors;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegisterRequest &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return Object.hash(username, email, password, isAdmin);
  }

  @override
  String toString() {
    return 'RegisterRequest(username: $username, email: $email, isAdmin: $isAdmin)';
  }

  /// Copy with method
  RegisterRequest copyWith({
    String? username,
    String? email,
    String? password,
    bool? isAdmin,
  }) {
    return RegisterRequest(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
