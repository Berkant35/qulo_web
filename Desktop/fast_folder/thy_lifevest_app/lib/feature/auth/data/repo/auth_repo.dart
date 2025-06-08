import 'package:dartz/dartz.dart';
import 'package:thy_lifevest_app/core/constant/api/api_helper.dart';
import 'package:thy_lifevest_app/core/constant/api/api_service.dart';
import 'package:thy_lifevest_app/core/constant/api/base/item_dto.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/auth/data/dto/login_dto.dart';
import 'package:thy_lifevest_app/feature/auth/data/param/login_param.dart';

class AuthRepo {
  const AuthRepo();
  
  Future<Either<Failure, ItemDto<LoginDto>>> login(LoginParam param) async {
    final signInEither = await ApiHelper.requestItem<LoginDto>(
      apiCall: () => sl<ApiService>().login(loginParam: param),
    );
    return signInEither;
  }
}
