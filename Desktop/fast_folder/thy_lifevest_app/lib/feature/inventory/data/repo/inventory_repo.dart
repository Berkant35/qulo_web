import 'package:dartz/dartz.dart';
import 'package:thy_lifevest_app/core/constant/api/api_helper.dart';
import 'package:thy_lifevest_app/core/constant/api/api_service.dart';
import 'package:thy_lifevest_app/core/constant/api/base/list_dto.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/inventory/data/dto/inventory_item_user_bank_dto.dart';
import 'package:thy_lifevest_app/feature/inventory/data/param/inventory_get_items_param.dart';

class InventoryRepo {
  const InventoryRepo();

  Future<Either<Failure, ListDto<InventoryItemUserBankDto>>> getInventoryItemsWithUserBanks(
    InventoryGetItemsParam param,
  ) async {
    final getItemsEither = await ApiHelper.requestList<InventoryItemUserBankDto>(
      apiCall: () => sl<ApiService>().getInventoryItemsWithUserBanks(param),
    );
    return getItemsEither;
  }
}
