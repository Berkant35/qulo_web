import 'package:equatable/equatable.dart';

/// Login request entity
/// Login işlemi için kullanılan request modeli
class LoginRequest extends Equatable {
  const LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: ****)';
  }
}
