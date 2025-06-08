import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_find_state.dart';

class InventoryFindCubit extends Cubit<InventoryFindState> {
  InventoryFindCubit() : super(const InventoryFindState());

  void setFindStatus(InventoryFindStatus status) {
    emit(state.copyWith(findStatus: status));
  }
}
