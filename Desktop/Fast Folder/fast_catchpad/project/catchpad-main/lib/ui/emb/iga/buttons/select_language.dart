import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/emb/iga/icons/iga_navigator_icon.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../prov/emb/emb_global_providers.dart';
import '../../../../utils/cp_colors.dart';

class SelectLanguage extends ConsumerStatefulWidget {
  final double? width;
  final double? height;
  final Function()? onPressedTr;
  final Function()? onPressedEn;

  const SelectLanguage(
      {this.onPressedTr, this.onPressedEn, this.width, this.height, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends ConsumerState<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    final langs = L10n.allLangModels();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  width: 1.px, color: CpColors.cpLightGreyIGA.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(64.px))),
          alignment: Alignment.center,
          height: widget.height ?? 20.h,
          width: widget.width ?? 40.w,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              ref.read(currentIgaPageManager.notifier).pageController!.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);

              ref.watch(appLangProv.notifier).setLanguage(langs[0]);
            },
            child: Container(
              width: 20.w,
              height: 20.h,
              color: Colors.transparent,
              child: const Center(
                child: IgaNavigatorIconWidget(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: SizedBox(
              width: 50.w,
              height: 25.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TextLogoWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "CATCHPAD'E HOŞGELDİN",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "|",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "WELCOME TO CATCHPAD",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 59.5.h,
            width: 27.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildIconButton(
                    "Türkçe", 'assets/iga/lang_tr.png', widget.onPressedTr),
                buildIconButton(
                    "English", 'assets/iga/lang_en.png', widget.onPressedEn),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildIconButton(
      String language, String imagePath, Function()? onPressedTr) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onPressedTr,
          icon: Image.asset(imagePath),
          constraints: BoxConstraints.tight(Size(12.w, 12.w)),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          language,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
