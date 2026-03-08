import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/subscription_service.dart';
import 'package:qulo_v2/data/models/subscription_model.dart';

class SubscriptionRepository {
  final SubscriptionService _service;

  SubscriptionRepository(this._service);

  Future<Result<SubscriptionInfo>> getStatus() async {
    try {
      final response = await _service.getStatus();
      return Success(response.subscription);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
