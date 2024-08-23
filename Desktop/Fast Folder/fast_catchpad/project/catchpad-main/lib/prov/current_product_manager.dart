import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product/product.dart';

typedef AllPadsProductInfo = Map<String, Product>;

class CurrentPadProductManagerNotifier
    extends StateNotifier<AllPadsProductInfo> {
  CurrentPadProductManagerNotifier(AllPadsProductInfo state) : super({});

  updateState(AllPadsProductInfo val) {
    state = val;
  }

  addProduct(Product? product, String macId) {

    if (product?.productId != null) {
      state.addAll({
        macId: product!,
      });
    } else {
      state.addAll(
          {
            macId: const Product(productOwnerUserName: "Undefined")});
    }
  }
}
