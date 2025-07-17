import 'package:equatable/equatable.dart';

/// Auth token entity
/// Authentication token bilgilerini tutan model
class AuthToken extends Equatable {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'Bearer',
    this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int? expiresIn;

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenType, expiresIn];

  @override
  String toString() {
    return 'AuthToken(tokenType: $tokenType, expiresIn: $expiresIn)';
  }
}
