import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_reader_constants.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_content_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';
import 'package:thy_lifevest_app/feature/inventory/data/dto/inventory_item_user_bank_dto.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';
import 'package:thy_lifevest_app/feature/inventory/data/repo/inventory_repo.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/cubit/reader_cubit.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

/// Inventory işlemlerini yöneten cubit
/// Reader cubit'i kullanarak RFID tag'lerini yönetir
/// Duplicate tag kontrolü ve otomatik initialize özelliği ile
class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(const InventoryState()) {
    // Constructor'da otomatik initialize et
    initialize();
  }

  final inventoryRepo = sl<InventoryRepo>();

  // Dependencies
  ReaderCubit get _readerCubit => sl<ReaderCubit>();

  StreamSubscription? _readerStateSubscription;
  final Set<String> _discoveredEpcSet = <String>{}; // Duplicate kontrolü için

  /// Cubit'i initialize eder ve reader state'ini dinler
  Future<void> initialize() async {
    try {
      // Kısa bekleme ile reader cubit'in hazır olmasını sağla
      await Future.delayed(const Duration(milliseconds: 100));

      // Reader state listener'ını başlat
      _listenToReaderState();

      // Current reader state'ini al ve senkronize et
      final currentReaderState = _readerCubit.state;

      if (!isClosed) {
        // Mevcut tag'leri set'e ekle (duplicate kontrolü için)
        _discoveredEpcSet.clear();
        for (final tag in currentReaderState.discoveredTags) {
          if (tag.epc != null) {
            _discoveredEpcSet.add(tag.epc!);
          }
        }

        // Initial state'i reader state ile senkronize et
        emit(
          state.copyWith(
            isInventoryRunning: currentReaderState.isInventoryRunning,
            discoveredTags: currentReaderState.discoveredTags,
            totalTagCount: currentReaderState.discoveredTags.length,
            connectedReaderName: currentReaderState.connectedDeviceAddress ?? '',
            isLoading: false,
            // Initialize tamamlandığında loading'i kapat
            failure: null, // Initialize sırasında error'ları temizle
          ),
        );
      }
    } catch (e) {
      debugPrint("[INVENTORY] Failed to initialize: $e");

      // Initialize error durumunda da basic state'i ayarla
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, statusMessage: "Initialization failed"));
      }
    }
  }

  /// Inventory işlemini başlatır
  Future<void> start() async {
    try {
      // Loading state'i başlat
      emit(
        state.copyWith(
          isLoading: true,
          statusMessage: AppStrings.startingInventory,
          failure: null, // Önceki error'ları temizle
        ),
      );

      // Inventory zaten çalışıyorsa önce durdur
      if (state.isInventoryRunning) {
        await _readerCubit.stopInventory();
        // State senkronizasyonu için kısa bekleme
        await Future.delayed(const Duration(milliseconds: 200));
      }

      // Reader'dan inventory'yi başlat
      await _readerCubit.startInventory();
      sl<InventoryContentCubit>().startPeriodicRequests();
      // State güncelleme
      emit(state.copyWith(isLoading: false, isInventoryRunning: true, statusMessage: AppStrings.inventoryStarted));
    } catch (e) {
      debugPrint("[INVENTORY] Failed to start inventory: $e");

      emit(
        state
            .setFailure(AppReaderConstants.startInventoryFailedCode, AppStrings.error, 'Failed to start inventory: $e')
            .copyWith(isLoading: false, isInventoryRunning: false, statusMessage: null),
      );
    }
  }

  /// Inventory işlemini durdurur
  Future<void> stop() async {
    debugPrint("[INVENTORY] 🛑 STOP BUTTON PRESSED!");
    try {
      
      emit(
        state.copyWith(
          statusMessage: AppStrings.stoppingInventory,
          failure: null,
          isLoading: true, isInventoryRunning: false,
        ),
      );

      await _readerCubit.stopInventory();
      
      emit(state.copyWith(isLoading: false, isInventoryRunning: false, statusMessage: AppStrings.inventoryStopped));
      // Status mesajını temizle
      Timer(const Duration(seconds: 1), () {
        if (!isClosed) {
          emit(state.copyWith(statusMessage: null));
        }
      });
    } catch (e) {
      debugPrint("[INVENTORY] Failed to stop inventory: $e");

      // Error durumunda da inventory'yi durdur
      emit(state.copyWith(isLoading: false, isInventoryRunning: false, statusMessage: "Inventory stopped with error"));

      // Status mesajını temizle
      Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          emit(state.copyWith(statusMessage: null));
        }
      });
    }
  }

  /// Reader state'ini dinler ve senkronize eder
  /// Duplicate tag kontrolü ile yeni tag'leri filtreler
  void _listenToReaderState() {
    try {
      _readerStateSubscription?.cancel();
      _readerStateSubscription = _readerCubit.stream.listen((readerState) {
        if (isClosed) return; // Cubit kapatıldıysa işlem yapma
        // Reader state değiştiğinde tag'leri senkronize et
        if (state.isInventoryRunning.isEquals(true)) {
          _syncDiscoveredTags(readerState.discoveredTags);
        }
      });
    } catch (e) {
      debugPrint("[INVENTORY] Failed to listen to reader state: $e");
    }
  }

  /// Tag'leri senkronize eder ve duplicate kontrolü yapar
  void _syncDiscoveredTags(List<ReaderTag> readerTags) {
    try {
      final List<ReaderTag> uniqueTags = [];
      int newTagCount = 0;

      // Yeni gelen tag'leri duplicate kontrolü ile filtrele
      for (final tag in readerTags) {
        final epc = tag.epc;

        if (epc != null) {
          final isAlreadyInSet = _discoveredEpcSet.contains(epc);
          final decodeMapByEpc = sl<ReaderCubit>().decodeGs1AdiEpc(epc);

          if (!isAlreadyInSet) {
            // final tagIsLifevest = decodeMapByEpc["filter_value"].isEquals(14);
            // if (tagIsLifevest.isEquals(true)) {
            //   debugPrint("[INVENTORY] Found lifevest tag: $epc, TID: $tid");
            // } else {
            //   debugPrint("[INVENTORY] ****");
            // }

            _discoveredEpcSet.add(epc);
            uniqueTags.add(tag);
            newTagCount++;
            LifevestTagModel lifevestTag = LifevestTagModel.fromDecodeEpcMap(decodeMapByEpc, tag);
            emit(state.copyWith(lifevestTags: {...state.lifevestTags, epc: lifevestTag}));
          }
        }
      }

      // Sadece yeni tag'ler varsa state'i güncelle
      if (newTagCount > 0) {
        final updatedTags = [...state.discoveredTags, ...uniqueTags];
        emit(state.copyWith(discoveredTags: updatedTags, totalTagCount: updatedTags.length));
        _showStatusMessage("Found $newTagCount new tags");
      }
    } catch (e) {
      debugPrint("[INVENTORY] Failed to sync discovered tags: $e");
    }
  }

  /// Discovered tag'leri temizler
  /// Hem local state hem de reader state'i temizlenir
  void clearTags() {
    try {
      debugPrint("[INVENTORY] 🧹 CLEAR BAŞLADI - Current tags: ${state.discoveredTags.length}");
      debugPrint("[INVENTORY] 🧹 CLEAR BAŞLADI - Set size: ${_discoveredEpcSet.length}");

      // 1. Önce reader listener'ını geçici olarak durdur
      debugPrint("[INVENTORY] 🧹 Stopping reader listener temporarily...");
      _readerStateSubscription?.cancel();

      // 2. Local duplicate control set'ini temizle
      _discoveredEpcSet.clear();
      debugPrint("[INVENTORY] 🧹 Local set cleared: ${_discoveredEpcSet.length}");

      // 3. Reader cubit'teki tag'leri de temizle
      debugPrint("[INVENTORY] 🧹 Clearing reader tags...");
      _readerCubit.clearDiscoveredTags();

      // 4. Local inventory state'ini temizle
      emit(
        state.copyWith(
          discoveredTags: [],
          lifevestTags: {},
          totalTagCount: 0,
          statusMessage: "Tags cleared",
          failure: null,
        ),
      );

      debugPrint("[INVENTORY] 🧹 State emitted - New tags count: ${state.discoveredTags.length}");

      // 5. 500ms sonra reader listener'ını yeniden başlat
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!isClosed) {
          debugPrint("[INVENTORY] 🧹 Restarting reader listener...");
          _listenToReaderState();
        }
      });

      debugPrint("[INVENTORY] 🧹 CLEAR COMPLETED SUCCESSFULLY");

      // Status mesajını 2 saniye sonra temizle
      Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          emit(state.copyWith(statusMessage: null));
        }
      });
    } catch (e) {
      debugPrint("[INVENTORY] ❌ CLEAR FAILED: $e");

      // Error durumunda da local state'i temizle
      _discoveredEpcSet.clear();
      emit(state.copyWith(discoveredTags: [], totalTagCount: 0, statusMessage: "Tags cleared with error"));

      // Listener'ı yeniden başlat
      if (!isClosed) {
        _listenToReaderState();
      }
    }
  }

  
  
  /// Hata mesajını temizler
  void clearError() {
    emit(state.clearFailure());
  }

  /// Status mesajını temizler
  void clearStatusMessage() {
    emit(state.copyWith(statusMessage: null));
  }

  /// Status mesajını gösterir
  void _showStatusMessage(String message) {
    try {
      if (!isClosed && message.isNotEmpty) {
        emit(state.copyWith(statusMessage: message));

        // Status mesajını 3 saniye sonra temizle
        Timer(const Duration(seconds: 3), () {
          if (!isClosed && state.statusMessage == message) {
            emit(state.copyWith(statusMessage: null));
          }
        });
      }
    } catch (e) {
      debugPrint("[INVENTORY] Failed to show status message: $e");
    }
  }

  void updateLifevestWithUserBankData(InventoryItemUserBankDto bankDto) {
    try {
      final findLifevest = state.lifevestTags[bankDto.epc];
      if (findLifevest.isNotNull) {
        final updatedLifevest = findLifevest!.copyWith(
          userHex: bankDto.userDataHex,
          uMfr: bankDto.userMfr,
          uSer: bankDto.userSer,
          uPno: bankDto.userPno,
          uSeq: bankDto.userSeq,
          uDmf: bankDto.userDmf,
          uExp: bankDto.userExp,
          uOther: bankDto.userOther,
        );
        emit(
          state.copyWith(
            lifevestTags: {...state.lifevestTags, (updatedLifevest.epcHex).getValueOrDefault: updatedLifevest},
          ),
        );
      }
    } catch (e) {
      debugPrint("[INVENTORY] Failed to update lifevest with user bank data: $e");
    }
  }

  void updateLifevestSetRequestDone(String epc) {
    try {
      final findLifevest = state.lifevestTags[epc];
      if (findLifevest.isNotNull) {
        final updatedLifevest = findLifevest!.copyWith(isRequestDone: true);
        emit(
          state.copyWith(
            lifevestTags: {...state.lifevestTags, (updatedLifevest.epcHex).getValueOrDefault: updatedLifevest},
          ),
        );
      }
    } catch (e) {
      debugPrint("[INVENTORY] Failed to update lifevest with user bank data: $e");
    }
  }
  

  @override
  Future<void> close() {
    _readerStateSubscription?.cancel();
    _discoveredEpcSet.clear();
    return super.close();
  }
}
