import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../l10n/l10n.dart';

class CustomCatchpadTextFields {


  static bool profanityFilter(String text) {
    final filter = ProfanityFilter();
    return filter.hasProfanity(text);
  }

  static Widget buildCompactTextField({
    String? hintText,
    String? validatorMessage,
    TextInputType? keyboardType,
    TextEditingController? controller,
    int? maxLength,
    required BuildContext context,
    bool isEmail = false,
    Color color = Colors.black,
    double? width,
    double? height,
  }) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            counterText: "",
            fillColor: CpColors.cpLead,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            hintText: hintText,
            hintStyle: Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: CpColors.cpDavysGrey)),
        validator: (value) {
          final bool isBad = profanityFilter(value ?? '');
          if (isBad) {
            return L10n
                .inst(context)
                .iga_enter_slang_free_text;
          }
          if (value == null || value.isEmpty) return validatorMessage;
          return isEmail ? emailValidator(value,context) : null;
        },
      ),
    );

  }
  static String? emailValidator(String? value, BuildContext context) {
    // E-posta doğrulama işlemi için bir düzen kullanın.
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Null ya da boş bir değer kontrolü
    if (value == null || value.isEmpty) {
      return L10n.inst(context).iga_email_cannot_empty;
    }

    // E-posta adresi düzenini kontrol etme
    if (!emailRegex.hasMatch(value)) {
      return L10n.inst(context).form_email_is_not_valid;
    }

    // Eğer e-posta adresi doğrulandıysa, null döndürerek hatasız olduğunu gösteririz.
    return null;
  }
}