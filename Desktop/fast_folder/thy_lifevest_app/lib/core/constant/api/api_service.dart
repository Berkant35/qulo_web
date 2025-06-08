import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:thy_lifevest_app/core/constant/api/app_endpoint.dart';
import 'package:thy_lifevest_app/core/constant/api/base/item_dto.dart';
import 'package:thy_lifevest_app/core/constant/api/base/list_dto.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/feature/auth/data/dto/login_dto.dart';
import 'package:thy_lifevest_app/feature/auth/data/param/login_param.dart';
import 'package:thy_lifevest_app/feature/inventory/data/dto/inventory_item_user_bank_dto.dart';
import 'package:thy_lifevest_app/feature/inventory/data/param/inventory_get_items_param.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //!Common Api's
  @POST(AppEndpoints.userLogin)
  Future<ItemDto<LoginDto>> login({@Body() required LoginParam loginParam});
  
  @POST(AppEndpoints.lifevestGetItems)
  Future<ListDto<InventoryItemUserBankDto>> getInventoryItemsWithUserBanks(@Body()  InventoryGetItemsParam inventoryGetItemsParam);
}
