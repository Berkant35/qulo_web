
import 'package:thy_lifevest_app/core/error/failure.dart';

class ServiceFailure extends Failure {
  ServiceFailure({
    super.errorText,
    super.code,
    super.errors,
  });
}

class NullPointerFailure extends Failure {
  NullPointerFailure({super.errorText});
}
