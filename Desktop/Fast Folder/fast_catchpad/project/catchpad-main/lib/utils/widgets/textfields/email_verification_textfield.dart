import 'dart:async';

import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/services/email_verification_service.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/enums/firebase/collenction_enums.dart';
import '../../../prov/emb/emb_global_providers.dart';

class EmailVerificationTextfield extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formkey;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int? maxLength;

  const EmailVerificationTextfield(
      {this.hintText,
      this.keyboardType = TextInputType.text,
      required this.controller,
      this.maxLength,
      super.key,
      required this.formkey});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfanityTextfieldState();
}

class _ProfanityTextfieldState
    extends ConsumerState<EmailVerificationTextfield> {
  bool _isValid = false;
  bool _isLoading = false;
  Timer? _debounce;

  void _onChangedHandler(String value) {
    // Zamanlayıcıyı sıfırlayın (varsa iptal edin)
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // 2 saniye bekleyip fonksiyonu çalıştıracak bir zamanlayıcı oluşturun
    _debounce = Timer(const Duration(seconds: 2), () async {
      // Bu kod 2 saniye boyunca hiçbir değişiklik olmadığında çalışacak
      if (validateEmail(value)) {
        final list = await FirebaseIgaCollectionEnumsWithField
            .iga_cached_emails.reference
            .where(
              "mail", isEqualTo: widget.controller.text
            )
            .get();

        if (list.docs.isEmpty) {
          FirebaseIgaCollectionEnumsWithField.iga_cached_emails.reference.add(
            {
              "mail": widget.controller.text,
              "date": DateTime.now().nowTimeddMMyyyyHHmmss,
              "kDebugMode": kDebugMode,
              "language": L10n.inst(context).language,
              "pier": kDebugMode
                  ? "DEMO"
                  : ref
                      .read(currentIgaResultManager.notifier)
                      .currentLocation
                      ?.igaLocationName,
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> _checkProfanity() async {
    final response =
        await EmailVerificationService().verifyEmail(widget.controller.text);
    setState(() {
      _isValid = response;
    });
  }

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mail address';
    }
    if (!_isValid) {
      return 'Mail address is not valid!';
    }
    return null;
  }

  Future<void> validate() async {
    // close the keyboard when tapped outside
    FocusScope.of(context).unfocus();
    if (widget.controller.text.isEmpty) return;
    changeStatus();
    await _checkProfanity();
    changeStatus();
    widget.formkey.currentState!.validate();
  }

  bool validateEmail(String email) {
    // Email regex pattern
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    // Check if email matches the pattern
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.white),
          controller: widget.controller,
          validator: _validateText,
          onChanged: (value) async {
            _onChangedHandler(value);
          },
          onEditingComplete: validate,
          onTapOutside: (event) async => validate(),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              fillColor: CpColors.cpLead,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: CpColors.cpDavysGrey)),
        ),
        Gap(1.h),
        _isLoading
            ? Row(
                children: [
                  Gap(4.w),
                  SizedBox(
                      height: 13.sp,
                      width: 13.sp,
                      child: CircularProgressIndicator(
                        color: CpColors.cpPrimary,
                        strokeWidth: 4.sp,
                      )),
                  Gap(2.w),
                  Text('Validity check......',
                      style: TextStyle(fontSize: 13.sp)),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  void changeStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
