import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Login user use case
/// Kullanıcı login işlemi için business logic
class LoginUser implements UseCase<AuthToken, LoginRequest> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, AuthToken>> call(LoginRequest params) async {
    // Email validation
    if (!_isValidEmail(params.email)) {
      return const Left(ValidationFailure('Geçerli bir email adresi girin'));
    }

    // Password validation
    if (params.password.length < 6) {
      return const Left(ValidationFailure('Şifre en az 6 karakter olmalı'));
    }

    // Login request
    final result = await repository.login(params);

    return result.fold(
      (failure) => Left(failure),
      (token) async {
        // Save token after successful login
        await repository.saveToken(token);
        return Right(token);
      },
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
