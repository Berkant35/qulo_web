import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentNeedOtaManager =
    StateNotifierProvider<NeedOtaPadsNotifier, List<String>>(
        (_) => NeedOtaPadsNotifier([]));

class NeedOtaPadsNotifier extends StateNotifier<List<String>> {
  NeedOtaPadsNotifier(List<String> state) : super([]);

  Future<void> initialize(WidgetRef ref) async {
    try {
      final map = await FirebaseFirestore.instance
          .collection(FirebaseCollectionEnums.need_ota_pads.name)
          .doc("pads")
          .get();

      final dynamicData = map.data();
      if (dynamicData != null && dynamicData.containsKey("padList")) {
        // Verinin doğru olduğunu ve "padList" anahtarının varlığını kontrol et
        final padListDynamic = dynamicData["padList"];
        if (padListDynamic is List<dynamic>) {
          // Eğer "padList" bir dinamik liste ise, String listesine dönüştür
          final padList = padListDynamic.cast<String>();
          state = padList;
        } else {
          logger.e("'padList' beklenen türde değil");
        }
      } else {
        logger.e("'padList' bulunamadı veya geçersiz veri");
      }
    } catch (e) {
      logger.e("Need Ota Pads From Firebase Error: $e");
    }
  }



  void add(WidgetRef ref) {}

  Future<void> delete(WidgetRef ref, String macId) async {
    try{
      await FirebaseCollectionEnums.need_ota_pads.reference
          .doc("pads")
          .update({
        "padList": FieldValue.arrayRemove([macId])
      });
      state.remove(macId);
    }catch(e){
      logger.e("Error: $e");
    }

  }
}
