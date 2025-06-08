import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:thy_lifevest_app/core/constant/api/base/item_dto.dart';
import 'package:thy_lifevest_app/core/constant/api/base/list_dto.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/error/general_failures.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/list_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/utils/error_manager.dart';

abstract class ApiHelper {
  /// Request item data from API
  static Future<Either<Failure, ItemDto<T>>> requestItem<T>({required Future<ItemDto<T>> Function() apiCall}) async {
    try {
      final result = await apiCall();

      if (result.status.isEquals(true)) {
        return Right(result);
      } else {
        sl<ErrorManager>().report("${result.code}", StackTrace.fromString(result.message.getValueOrDefault));
        return Left(
          ServiceFailure(
            errorText: result.message,
            errors: result.errors.getValueOrDefault,
            code: result.code,
          ),
        );
      }
    } on DioException catch (e, stackTrace) {
      sl<ErrorManager>().report(e, stackTrace);
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        return Left(ServiceFailure(errorText: null));
      }

      return Left(
        ServiceFailure(
          errorText: e.response?.data?["message"] ?? AppStrings.somethingWentWrong,
          code: e.response?.data?["code"] ?? AppStrings.unKnownErrorCode,
        ),
      );
    } catch (err, stackTrace) {
      sl<ErrorManager>().report(err, stackTrace);
      return Left(ServiceFailure(errorText: "Error : $err"));
    }
  }

  /// Request list data from API
  static Future<Either<Failure, ListDto<T>>> requestList<T>({required Future<ListDto<T>> Function() apiCall}) async {
    try {
      final result = await apiCall();
      if (result.status) {
        return Right(result);
      } else {
        sl<ErrorManager>().report("${result.errorCode}", StackTrace.fromString(result.message.getValueOrDefault));
        return Left(ServiceFailure(errorText: "${result.errorCode} :${result.message}"));
      }
    } catch (err, stackTrace) {
      sl<ErrorManager>().report(err, stackTrace);
      return Left(ServiceFailure(errorText: "Error : $err"));
    }
  }
}
