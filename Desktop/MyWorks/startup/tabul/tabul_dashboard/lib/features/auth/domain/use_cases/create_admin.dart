import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Create admin use case
/// Özel bilgilerle admin oluşturma
class CreateAdmin implements UseCase<User, CreateAdminRequest> {
  final AuthRepository repository;

  CreateAdmin(this.repository);

  @override
  Future<Either<Failure, User>> call(CreateAdminRequest request) async {
    // Input validation
    if (!request.isValid) {
      return Left(ValidationFailure(
          'Validation hatası: ${request.validationErrors.join(', ')}'));
    }

    // Repository call
    return await repository.createAdmin(request);
  }
}
