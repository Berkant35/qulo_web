import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(UIStateStatus.idle) UIStateStatus status,
  }) = _SplashState;
}
