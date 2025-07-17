import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Get user by username use case
/// Username ile kullanıcı arama
class GetUserByUsername implements UseCase<User, GetUserByUsernameParams> {
  final AuthRepository repository;

  GetUserByUsername(this.repository);

  @override
  Future<Either<Failure, User>> call(GetUserByUsernameParams params) async {
    // Input validation
    if (params.username.isEmpty) {
      return Left(ValidationFailure('Username boş olamaz'));
    }

    // Repository call
    return await repository.getUserByUsername(params.username);
  }
}

/// Get user by username parameters
class GetUserByUsernameParams {
  final String username;

  const GetUserByUsernameParams({required this.username});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetUserByUsernameParams && other.username == username;
  }

  @override
  int get hashCode => username.hashCode;

  @override
  String toString() => 'GetUserByUsernameParams(username: $username)';
}
