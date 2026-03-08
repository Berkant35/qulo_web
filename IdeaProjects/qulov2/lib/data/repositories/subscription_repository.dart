import 'package:dio/dio.dart';
import '../../core/network/result.dart';
import '../../core/network/services/subscription_service.dart';
import '../models/subscription_model.dart';

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
