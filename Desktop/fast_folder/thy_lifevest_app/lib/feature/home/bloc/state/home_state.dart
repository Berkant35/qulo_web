import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,
  }) = _HomeState;

  const HomeState._();
}
