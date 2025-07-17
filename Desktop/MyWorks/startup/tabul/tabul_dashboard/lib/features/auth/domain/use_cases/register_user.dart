import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Register user use case
/// Yeni kullanıcı/admin kaydı
class RegisterUser implements UseCase<User, RegisterRequest> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterRequest request) async {
    // Input validation
    if (!request.isValid) {
      return Left(ValidationFailure(
          'Validation hatası: ${request.validationErrors.join(', ')}'));
    }

    // Repository call
    return await repository.registerUser(request);
  }
}
