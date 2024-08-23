import 'package:flutter_riverpod/flutter_riverpod.dart';

final eduItemProv =
    StateNotifierProvider<EducationItemProvider, EducationItemModel?>(
  (_) => EducationItemProvider(null),
);

class EducationItemProvider extends StateNotifier<EducationItemModel?> {
  EducationItemProvider(EducationItemModel? state) : super(state);

  setItem(EducationItemModel educationItemModel) {
    state = educationItemModel;
  }

  reset() {
    state = null;
  }
}

class EducationItemModel {
  EducationItemModel({required this.item, required this.imagePath});
  final String item;
  final String imagePath;
}
