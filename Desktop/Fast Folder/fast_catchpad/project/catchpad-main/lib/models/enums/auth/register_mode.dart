import 'login_mode.dart';

enum RegisterMode { email, phone }

extension RegisterModeEx on RegisterMode {
  LoginMode get toLoginMode {
    switch (this) {
      case RegisterMode.email:
        return LoginMode.email;
      case RegisterMode.phone:
        return LoginMode.phone;
    }
  }
}
