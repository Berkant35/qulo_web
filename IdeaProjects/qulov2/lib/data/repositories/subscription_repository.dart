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
      final subscription = response['subscription'] as Map<String, dynamic>?;
      if (subscription != null) {
        return Success(SubscriptionInfo.fromJson(subscription));
      }
      return Success(SubscriptionInfo.free());
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<SubscriptionInfo>> verifyPurchase({
    required String productId,
    required String receipt,
    required String platform,
  }) async {
    try {
      final response = await _service.verifyPurchase({
        'product_id': productId,
        'receipt': receipt,
        'platform': platform,
      });
      final subscription = response['subscription'] as Map<String, dynamic>?;
      if (subscription != null) {
        return Success(SubscriptionInfo.fromJson(subscription));
      }
      return Success(SubscriptionInfo.free());
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
