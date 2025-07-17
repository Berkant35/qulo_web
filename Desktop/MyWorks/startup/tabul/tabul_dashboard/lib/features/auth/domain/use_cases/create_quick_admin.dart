import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Create quick admin use case
/// Varsayılan bilgilerle admin oluşturma (admin/dad.153hb)
class CreateQuickAdmin implements UseCase<User, NoParams> {
  final AuthRepository repository;

  CreateQuickAdmin(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.createQuickAdmin();
  }
}
