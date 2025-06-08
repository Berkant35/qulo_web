import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/list_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/preferences/i_pref.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_content_state.dart';
import 'package:thy_lifevest_app/feature/inventory/data/dto/inventory_item_user_bank_dto.dart';
import 'package:thy_lifevest_app/feature/inventory/data/param/inventory_get_items_param.dart';
import 'package:thy_lifevest_app/feature/inventory/data/repo/inventory_repo.dart';

class InventoryContentCubit extends Cubit<InventoryContentState> {
  InventoryContentCubit() : super(const InventoryContentState());

  Timer? _periodicTimer;
  final inventoryRepo = sl<InventoryRepo>();
  final inventoryCubit = sl<InventoryCubit>();
  final authPref = sl<AuthPref>();

  Future<void> init() async {
    final accessToken = await authPref.getAccessToken();
    if (accessToken.isNotNull) {
      emit(state.copyWith(accessToken: accessToken));
      listenInventoryCubit();
    } else {
      emit(state.copyWith(accessToken: null));
    }
  }

  //Start inventory denilince bunu yapar.
  void startPeriodicRequests() {
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (state.waitingToSendLifevestTags.isEmpty.isEquals(true)) {
        debugPrint("[INVENTORY CONTENT] No waiting tags to send.");
        return;
      }
      final getInventoryItemsResponse = await inventoryRepo.getInventoryItemsWithUserBanks(
        InventoryGetItemsParam(
          accessToken: state.accessToken.getValueOrDefault,
          itemList: state.waitingToSendLifevestTags.map((tag) => tag.toInventoryItem).toList(),
        ),
      );

      getInventoryItemsResponse.fold(
        (error) =>
            debugPrint("Error fetching inventory items: ${error.message} ${error.errorText} ${error.errorTitle}"),
        (response) {
          if (response.status.isEquals(true)) {
            _handleResponse(response.data);
          }
        },
      );
      for (var perWaitingToSendLifevestTag in state.waitingToSendLifevestTags) {
        final setTrueIsDone = perWaitingToSendLifevestTag.copyWith(isRequestDone: true);
        inventoryCubit.updateLifevestSetRequestDone(setTrueIsDone.epcHex);
      }
      
      emit(state.copyWith(waitingToSendLifevestTags: []));
    });
  }

  void stopPeriodicRequests() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  void listenInventoryCubit() {
    sl<InventoryCubit>().stream.listen((inventoryState) {
      final lifevestTags = inventoryState.lifevestTags;
      final waitingToSendLifevestTags =
          lifevestTags.values.toList().where((perTag) => perTag.isRequestDone.isEquals(false)).toList();
      emit(
        state.copyWith(
          lifevestTags: lifevestTags.values.toList(),
          waitingToSendLifevestTags: waitingToSendLifevestTags,
        ),
      );
    });
  }

  void setFilter(InventoryContentFilters filter) {
    if (state.selectedFilter == filter) return;
    emit(state.copyWith(selectedFilter: filter));
  }

  void _handleResponse(List<InventoryItemUserBankDto>? data) {
    for (var perItemUserBank in data.getValueOrDefault) {
      inventoryCubit.updateLifevestWithUserBankData(perItemUserBank);
    }
  }
}
