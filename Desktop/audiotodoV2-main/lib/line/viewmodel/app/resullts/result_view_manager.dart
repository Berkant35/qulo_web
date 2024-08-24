import 'package:audiotodo/utilities/constants/enums/meet/result_view_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultViewStateControlNotifier extends StateNotifier<ResultViewStates> {
  ResultViewStateControlNotifier(ResultViewStates state) : super(ResultViewStates.summary);
  bool _createForDetail = false;
  bool get createForDetail => _createForDetail;



  void setCreateForDetail(bool val) => _createForDetail = val;

  void changState(ResultViewStates val) => state = val;
}
