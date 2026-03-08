import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'subscription_service.g.dart';

@RestApi()
abstract class SubscriptionService {
  factory SubscriptionService(Dio dio) = _SubscriptionService;

  @GET('/subscriptions/status')
  Future<Map<String, dynamic>> getStatus();

  @POST('/subscriptions/verify')
  Future<Map<String, dynamic>> verifyPurchase(
    @Body() Map<String, dynamic> data,
  );
}
