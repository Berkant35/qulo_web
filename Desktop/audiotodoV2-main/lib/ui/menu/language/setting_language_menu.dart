import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/buttons/basic_back_button.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../generated/l10n.dart';

class SettingsLanguageMenu extends ConsumerStatefulWidget {
  const SettingsLanguageMenu({
    super.key,
  });

  @override
  ConsumerState createState() => _SettingsLanguageMenuState();
}

class _SettingsLanguageMenuState extends ConsumerState<SettingsLanguageMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.fillWhiteColor.withOpacity(0.97),
      appBar: BasicBackAppBar(
        contentTitle: S.current.language,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            explainOfDropDown(S.current.language_settings_application_explain),
            applicationLanguageSet(),
            SizedBox(height: 4.h),
            explainOfDropDown(S.current.language_settings_recognition_explain),
            applicationMicrophone(),
          ],
        ),
      ),
    );
  }

  Padding explainOfDropDown(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 5.w),
      child: Text(
        content,
        style: ThemeValueExtension.subtitle.copyWith(
            color: CustomColors.textGreyColor, overflow: TextOverflow.clip),
      ),
    );
  }

  Container applicationMicrophone() {
    return Container(
      height: 10.h,
      width: 100.w,
      color: CustomColors.fillWhiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 2.w,),
                  Icon(
                    Icons.mic,
                    size: 4.h,
                    color: CustomColors.accentColor,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      ref.watch(currentLanguageManager)?.name ?? S.current.language,
                      style: ThemeValueExtension.listTileTitleStyle.copyWith(
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            DropdownButton<LocaleName>(
                underline: const SizedBox(),
                style: ThemeValueExtension.subtitle5
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                value: null,
                items: [
                  for (int i = 0;
                      i <
                          ref
                              .watch(currentLanguageManager.notifier)
                              .currentLocales
                              .length;
                      i++)
                    DropdownMenuItem(
                      value: ref
                          .watch(currentLanguageManager.notifier)
                          .currentLocales[i],
                      child: Text(
                        ref
                            .watch(currentLanguageManager.notifier)
                            .currentLocales[i]
                            .name,
                        style: ThemeValueExtension.subtitle,
                      ),
                    )
                ],
                onChanged: (val) {
                  ref
                      .read(currentLanguageManager.notifier)
                      .changeRecognitionLanguage(val!,ref);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }

  Container applicationLanguageSet() {
    return Container(
      height: 10.h,
      width: 100.w,
      color: CustomColors.fillWhiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 2.w,),
                Icon(
                  Icons.language,
                  size: 4.h,
                  color: CustomColors.accentColor,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  S.current.language_local_word,
                  style: ThemeValueExtension.listTileTitleStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            DropdownButton<String>(
                underline: const SizedBox(),
                style: ThemeValueExtension.subtitle2
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                value: S.current.language_code,
                items: [
                  for (int i = 0; i < S.delegate.supportedLocales.length; i++)
                    DropdownMenuItem(
                      value: S.delegate.supportedLocales[i].languageCode,
                      child: Row(
                        children: [
                          Text(
                            Locale(
                              S.delegate.supportedLocales[i].languageCode,
                            ).flagEmoji!,
                            style: ThemeValueExtension.headline5,
                          ),
                        ],
                      ),
                    )
                ],
                onChanged: (val) {
                  ref
                      .read(currentLanguageManager.notifier)
                      .changeLocalLanguage(Locale(val!), ref);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}
