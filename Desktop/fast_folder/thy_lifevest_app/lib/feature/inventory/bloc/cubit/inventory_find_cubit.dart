import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_find_state.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/cubit/reader_cubit.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

class InventoryFindCubit extends Cubit<InventoryFindState> {
  InventoryFindCubit() : super(const InventoryFindState());

  StreamSubscription<ReaderState>? _readerSubscription;
  Timer? _searchTimer;

  /// Initialize reader state subscription
  void init() {
    _readerSubscription = sl<ReaderCubit>().stream.listen((readerState) {
      // Find mode aktifse ve target EPC'yi arıyorsak
      if (readerState.isFindMode && state.setTagModel != null) {
        final targetEpc = state.setTagModel!.epcHex;

        // Discovered tags'te target var mı kontrol et
        final foundTag =
            readerState.discoveredTags
                .where((tag) => tag.epc == targetEpc)
                .lastOrNull;

        if (foundTag != null) {
          final signalStrength = foundTag.rssi?.abs().toInt() ?? 0;

          emit(
            state.copyWith(
              findStatus: InventoryFindStatus.found,
              signalStrength: signalStrength,
              isTargetFound: true,
            ),
          );

          // Auto stop search after finding
          Future.delayed(const Duration(milliseconds: 500), () {
            _stopSearch();
          });
        }
      }
    });
  }

  /// Start searching for the selected tag
  Future<void> startSearch() async {
    if (state.setTagModel.isNull) return;

    emit(
      state.copyWith(
        findStatus: InventoryFindStatus.searching,
        isTargetFound: false,
        searchDuration: 0,
        signalStrength: 0,
      ),
    );

    // Search timer başlat (30 saniye timeout)
    _startSearchTimer();

    // Reader'da find mode başlat
    await sl<ReaderCubit>().startFindMode(state.setTagModel!.epcHex);
  }

  /// Stop the current search
  Future<void> stopSearch() async {
    await sl<ReaderCubit>().stopFindMode();
    await sl<ReaderCubit>().stopInventory();
    _stopSearch();
  }

  /// Set the tag to be found
  void setFindTag(LifevestTagModel lifevestTagModel) {
    emit(state.copyWith(setTagModel: lifevestTagModel));
  }

  /// Set find status manually
  void setFindStatus(InventoryFindStatus status) {
    emit(state.copyWith(findStatus: status));
  }

  /// Start search timer with 1 second intervals
  void _startSearchTimer() {
    _searchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final newDuration = state.searchDuration + 1;
      emit(state.copyWith(searchDuration: newDuration));

      // 30 saniye timeout
      if (newDuration >= 30) {
        emit(state.copyWith(findStatus: InventoryFindStatus.timeout));
        _stopSearch();
      }
    });
  }

  /// Stop search and cleanup
  void _stopSearch() {
    _searchTimer?.cancel();
    _searchTimer = null;
    emit(
      state.copyWith(findStatus: InventoryFindStatus.idle, searchDuration: 0),
    );
  }

  /// Clear the selected tag
  void clearSelectedTag() {
    emit(state.copyWith(setTagModel: null));
  }

  @override
  Future<void> close() {
    _readerSubscription?.cancel();
    _searchTimer?.cancel();
    return super.close();
  }
}
