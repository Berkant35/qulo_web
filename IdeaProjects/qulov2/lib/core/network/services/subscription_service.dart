import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:qulo_v2/data/models/subscription_model.dart';

part 'subscription_service.g.dart';

@RestApi()
abstract class SubscriptionService {
  factory SubscriptionService(Dio dio) = _SubscriptionService;

  @GET('/subscriptions/status')
  Future<SubscriptionStatusResponse> getStatus();
}
