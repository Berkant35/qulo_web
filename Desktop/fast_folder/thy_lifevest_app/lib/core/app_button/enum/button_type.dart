import 'package:thy_lifevest_app/core/extension/generic_extension.dart';

enum ButtonType { filled, outlined, icon, text }

extension ButtonTypeExtension on ButtonType {
  bool get isOutlined => isEquals(ButtonType.outlined);
}
