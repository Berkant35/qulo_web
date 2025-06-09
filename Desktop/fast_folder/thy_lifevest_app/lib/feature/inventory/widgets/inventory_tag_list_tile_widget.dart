import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/shared/app_bottom_sheet.dart';
import 'package:thy_lifevest_app/core/theme/app_box_decorations.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';
import 'package:thy_lifevest_app/feature/inventory/view/inventory_find_tag.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

/// Inventory tag list item widget'ı
/// Tek bir tag'i görüntüler ve find butonu sağlar
/// Kurallara uygun: StatelessWidget, AppTextStyles, AppStrings, AppColors, Extension kullanımı
class InventoryTagListTileWidget extends StatelessWidget {
  const InventoryTagListTileWidget({super.key, required this.tag, required this.lifevestModel, required this.tagIndex});

  final ReaderTag tag;
  final LifevestTagModel? lifevestModel;
  final int tagIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: AppBoxDecorations.basicCardDecoration.copyWith(color: _getByInfoColor(lifevestModel)),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                _TagInfoWidget(lifevestModel: lifevestModel),
                _EpcInfoWidget(tag: tag),
                _TagNumberWidget(tagIndex: tagIndex),
              ],
            ),
          ),
          Expanded(flex: 3, child: _FindButtonWidget(lifevestTagModel: lifevestModel)),
        ],
      ),
    );
  }

  Color? _getByInfoColor(LifevestTagModel? lifevestModel) {
    if ((lifevestModel?.isRequestDone).isEquals(false) &&
        ((lifevestModel?.userHex).isNull || ((lifevestModel?.userHex).isEmpty))) {
      return AppColors.orange.withValues75;
    }

    if ((lifevestModel?.isRequestDone).isEquals(true) &&
        ((lifevestModel?.userHex).isNull || ((lifevestModel?.userHex).isEmpty))) {
      return AppColors.gray500.withValues20;
    }

    return lifevestModel?.expiryStatusColor;
  }
}

/// Tag bilgilerini gösteren widget
/// Kurallara uygun: StatelessWidget, AppStrings kullanımı
class _TagInfoWidget extends StatelessWidget {
  const _TagInfoWidget({super.key, required this.lifevestModel});

  final LifevestTagModel? lifevestModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lifevestModel?.eMfr.isNotNull == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppStrings.mfrLabel}: ${lifevestModel?.eMfr ?? ''}", style: AppTextStyles.px14w600),
              Text(
                "  ${AppStrings.constLabel}: ${lifevestModel?.eConst ?? 0}",
                textAlign: TextAlign.end,
                style: AppTextStyles.px14w600,
              ),
            ],
          ),
        Visibility(
          visible: (lifevestModel?.eConst ?? 0) == 1,
          replacement: Text(
            "${AppStrings.pnoLabel}: ${lifevestModel?.ePno ?? ''} - ${AppStrings.seqLabel}: ${lifevestModel?.eSeq ?? ''}",
            style: AppTextStyles.px14w600,
          ),
          child: Text("${AppStrings.serLabel}: ${lifevestModel?.eSer ?? ''}", style: AppTextStyles.px14w600),
        ),
      ],
    );
  }
}

/// EPC bilgisini gösteren widget
/// Kurallara uygun: StatelessWidget, AppTextStyles kullanımı
class _EpcInfoWidget extends StatelessWidget {
  const _EpcInfoWidget({required this.tag});

  final ReaderTag tag;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppStrings.epcLabel}: ${tag.epc.getValueOrDefault}',
      style: AppTextStyles.px12w600,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Tag numarasını gösteren widget
/// Kurallara uygun: StatelessWidget, AppTextStyles, AppStrings kullanımı
class _TagNumberWidget extends StatelessWidget {
  const _TagNumberWidget({super.key, required this.tagIndex});

  final int tagIndex;

  @override
  Widget build(BuildContext context) {
    return Text('${AppStrings.tagNumber} #$tagIndex', style: AppTextStyles.px10w400);
  }
}

/// Find butonunu gösteren widget
/// Kurallara uygun: StatelessWidget, AppButton, AppStrings, AppColors kullanımı
class _FindButtonWidget extends StatelessWidget {
  final LifevestTagModel? lifevestTagModel;

  const _FindButtonWidget({required this.lifevestTagModel});

  @override
  Widget build(BuildContext context) {
    return AppButton.filled(
      text: AppStrings.find,
      height: 40,
      textStyle: AppTextStyles.px14w600.copyWith(color: AppColors.white),
      onTap: () async {
        if (lifevestTagModel.isNull)  return;
        AppBottomSheet(
          child: InventoryFindTag(lifevestTagModel: lifevestTagModel),
          fitToContent: true,
          closedBottomModel: () {},
        ).show();
      },
    );
  }
}
