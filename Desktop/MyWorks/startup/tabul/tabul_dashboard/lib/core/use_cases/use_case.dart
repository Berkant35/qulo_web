import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// Base class for all use cases in the application
///
/// [Type] - Type of data returned
/// [Params] - Type of parameters passed to the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Default empty parameters class for use cases that don't require parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
