/// Create admin request entity
/// Backend API'ye admin oluşturma isteği için model
class CreateAdminRequest {
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  const CreateAdminRequest({
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = true, // Admin oluşturma için default true
  });

  /// Validation için username kontrolü
  bool get isValidUsername => username.length >= 3 && username.length <= 50;

  /// Validation için email kontrolü
  bool get isValidEmail => email.contains('@') && email.contains('.');

  /// Validation için password kontrolü
  bool get isValidPassword => password.length >= 6;

  /// Tüm validation kontrolü
  bool get isValid => isValidUsername && isValidEmail && isValidPassword;

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
    return other is CreateAdminRequest &&
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
    return 'CreateAdminRequest(username: $username, email: $email, isAdmin: $isAdmin)';
  }
}
