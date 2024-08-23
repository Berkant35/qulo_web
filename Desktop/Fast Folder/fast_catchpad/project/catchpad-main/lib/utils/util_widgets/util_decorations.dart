import 'package:catchpad/models/game/metadata/game_metadata_model.dart';
import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../prov/auth/current_user_prov.dart';
import '../../prov/game/detail_game_prov.dart';

class CustomUtilDecorations {
  static Widget defaultDemoFormulaBgGameSettingsOfDetails(
      {required WidgetRef ref}) {
    final game = ref.watch(detailGameProv);

    final meta = game!.metaData;

    return Stack(
      children: [
        _gameImage(meta, ref),
        _backButton(ref.context),
      ],
    );
  }

  static Widget _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.height * 0.06,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: CpColors.cpPlatinum,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static ClipRRect _gameImage(GameMetaDataModel meta, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radiusBar()),
        bottomRight: Radius.circular(radiusBar()),
      ),
      child: Stack(
        children: [
          Image.asset(
            meta.fullImgPath,
            width: double.infinity,
            height: 50.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            // Alt kenara göre pozisyonunu ayarlayabilirsiniz
            left: 0,
            // İsteğe bağlı olarak sol kenara göre pozisyonunu ayarlayabilirsiniz
            right: 0,
            //
            child: customGameMetaInfo(ref, meta),
          )
        ],
      ),
    );
  }

  static double radiusBar() => 7.w;

  static Widget customGameMetaInfo(WidgetRef ref, GameMetaDataModel meta) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radiusBar()),
        topRight: Radius.circular(radiusBar()),
      ),
      child: Container(
        width: double.infinity,
        height: 33.h,
        color: CpColors.cpEerieBlack,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Expanded(flex: 7, child: gameInfoHeader(ref, meta)),
              const Spacer(flex: 1),
              Expanded(flex: 6, child: gameChips(ref, meta)),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  static Widget gameInfoHeader(WidgetRef ref, GameMetaDataModel meta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        favWithTitle(ref),
        gameDescription(meta.description, ref),
      ],
    );
  }

  static Widget favWithTitle(WidgetRef ref) {
    final metaData = ref.read(detailGameProv);
    final gameTitle = metaData?.title ?? "-";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          gameTitle,
          style: Theme.of(ref.context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        IconButton(
            onPressed: () async {
              final favoriteGames = ref.read(currentUserAssetsProv).favorites!;
              if (favoriteGames.contains(metaData.id)) {
                ref
                    .read(currentUserAssetsProv.notifier)
                    .removeFromFavorites(metaData.id);
              } else {
                ref
                    .read(currentUserAssetsProv.notifier)
                    .addToFavorites(metaData.id);
              }
              if (ref.read(selectedGameCategoryProv) ==
                  GameCategory.favorites) {
                ref.read(selectedGameCategoryIsFav.notifier).state =
                    !ref.read(selectedGameCategoryIsFav);
              }
            },
            icon: Icon(
              (ref
                      .watch(currentUserAssetsProv)
                      .favorites!
                      .contains(metaData!.id))
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: (ref
                      .watch(currentUserAssetsProv)
                      .favorites!
                      .contains(metaData.id))
                  ? Colors.red
                  : Colors.white,
            ))
      ],
    );
  }

  static Widget gameDescription(String description, WidgetRef ref) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: Theme.of(ref.context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                overflow: TextOverflow.clip),
          ),
          Text(
            "show more",
            style: Theme.of(ref.context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 12.sp, color: CpColors.cpLightGrey),
          )
        ],
      );

  static Widget gameChips(WidgetRef ref, GameMetaDataModel meta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity Goals",
          style: Theme.of(ref.context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              overflow: TextOverflow.clip),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 2.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int i=0;i<meta.earnings.length;i++)
               Padding(
                 padding:  EdgeInsets.only(right: 3.w),
                 child: CustomCatchpadButtons.buildGradientBorderButton(
                      onPressed: null,
                      text: meta.earnings[i].name,
                      borderRadius: 15.w,
                      backColor: CpColors.cpLightGrey.withOpacity(0.1)),
               ),

            ],
          ),
        )
      ],
    );
  }
}
