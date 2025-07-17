import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Get current user use case
/// Mevcut kullanıcı bilgilerini alma için business logic
class GetCurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    // Check if user is logged in
    final isLoggedIn = await repository.isLoggedIn();
    if (!isLoggedIn) {
      return const Left(AuthFailure('Kullanıcı giriş yapmamış'));
    }

    return await repository.getCurrentUser();
  }
}
