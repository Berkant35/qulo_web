import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/auth_repository.dart';

/// Logout user use case
/// Kullanıcı logout işlemi için business logic
class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    // Clear stored token
    await repository.clearToken();

    // Call logout endpoint
    return await repository.logout();
  }
}
