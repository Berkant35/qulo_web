import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/utility/pad_error_enums.dart';
import 'package:catchpad/models/product/product_error_log.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product/product.dart';

typedef DeviceMatchToPadErrorConfigList = Map<String, PadErrorConfigList>;

//Firebase eğer padlerde sıkıntı varsa bu durumu günceller
class PadErrorsProvNotifier
    extends StateNotifier<DeviceMatchToPadErrorConfigList> {
  PadErrorsProvNotifier(DeviceMatchToPadErrorConfigList state) : super({});

  void updateCurrentConfigList(
      PadErrorConfigList value, String deviceId, WidgetRef ref) {}

  Future<void> getConfigList(String deviceId, WidgetRef ref) async {
    PadManager.requestErrorLog(deviceId, ref: ref, withResponse: false)
        .then((value) {
      PadManager.readErrorLog(deviceId, ref: ref, withResponse: false)
          .then((errorLog) async {
        int unknownCounter = 0;

        if (!ref.context.mounted) return;

        final deviceInfo = ref.read(currentDevicesManagerProvider)[deviceId];

        if (deviceInfo == null || ref.read(currentEmbModeManager) == 1) return;

        final product = await FirebaseCollectionEnums.products.reference
            .withConverter<Product>(
                fromFirestore: (snapshot, options) =>
                    Product.fromJson(snapshot.data()!),
                toFirestore: (value, options) => value.toJson())
            .doc(deviceInfo!.macId)
            .get();

        final currentProductErrorLog = await FirebaseCollectionEnums
            .products_error_status.reference
            .withConverter<ProductErrorLog>(
                fromFirestore: (snapshot, options) =>
                    ProductErrorLog.fromJson(snapshot.data()!),
                toFirestore: (value, options) => value.toJson())
            .doc(deviceInfo.macId)
            .get();

        final productData = product.data();

        if (!ref.context.mounted) return;

        if (productData?.productId != null) {
          ref
              .read(currentDevicesProductManager.notifier)
              .addProduct(productData!, deviceInfo.macId!);
        } else {
          ref
              .read(currentDevicesProductManager.notifier)
              .addProduct(null, deviceInfo.macId!);
        }

        var productErrorLog = ProductErrorLog(
          productOwnerId: productData?.productOwnerId ?? "-",
          productId: productData?.productId ?? "-",
          productOwner: productData?.productOwnerUserName ?? "-",
          unKnownCounter: 0,
          accInitError: false,
          dstInitError: false,
          noBatOrOvpError: false,
          lowBatVoltageError: false,
          serialNumber: '',
        );

        PadErrorTypes.getAllPadErrorStatus(errorLog.toString())
            .forEach((key, value) {
          switch (key) {
            case PadErrorTypes.unKnown:
              if (value) {
                unknownCounter++;
                productErrorLog =
                    productErrorLog.copyWith(unKnownCounter: unknownCounter);
              }
              break;
            case PadErrorTypes.accInitError:
              productErrorLog = productErrorLog.copyWith(accInitError: value);
              break;
            case PadErrorTypes.dstInitError:
              productErrorLog = productErrorLog.copyWith(dstInitError: value);
              break;
            case PadErrorTypes.noBatOrOvpError:
              productErrorLog =
                  productErrorLog.copyWith(noBatOrOvpError: value);
              break;
            case PadErrorTypes.lowBatVoltageError:
              productErrorLog =
                  productErrorLog.copyWith(lowBatVoltageError: value);
              break;
          }
        });

        //TODO DB DE KAYITLI OLMAYANI DA ÇEKMEYE ÇALIŞIYORUZ!
        if (((productErrorLog.lowBatVoltageError || productErrorLog.noBatOrOvpError || productErrorLog.dstInitError ||
                    productErrorLog.accInitError ||
                    (productErrorLog.unKnownCounter > 0)))) {
          FirebaseCollectionEnums.products_error_status.reference
              .doc(productErrorLog.productId)
              .set(productErrorLog.toJson());
        }
      });
    });
  }
}
