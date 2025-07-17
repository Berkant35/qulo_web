import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

/// Get all admins use case
/// Sistemdeki tüm admin kullanıcıları listele
class GetAllAdmins implements UseCase<List<User>, NoParams> {
  final AuthRepository repository;

  GetAllAdmins(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getAllAdmins();
  }
}
