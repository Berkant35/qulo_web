import 'package:catchpad/models/enums/icon_paths.dart';
import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../../models/game/game_drop_options_model.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../utils/l10n/l10n.dart';

class GameOptionSetupWidget extends ConsumerStatefulWidget {
  const GameOptionSetupWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameOptionSetupWidgetState();
}

class _GameOptionSetupWidgetState extends ConsumerState<GameOptionSetupWidget> {
  final GlobalKey ctkey = GlobalKey();
  DropOption? selected;
  late String gameId;
  final key = CacheSetupKeys.dropOption.name;
  bool onceTime = false;
  List<DropOption> list = [];

  @override
  void initState() {
    super.initState();
    // İlgili sağlayıcılardan verileri alarak liste ve selected değerlerini ayarlayın
    final setup = ref.read(currentGameSetupProv);
    gameId = ref.read(currentGameMetaDataProv)!.id;
    list = setup!.gameDropOptionsModel!.options ?? [];

    // `currentDropOptionManager`'dan okunan değeri ayarlayın
    final DropOption? dropOption = ref.read(currentDropOptionManager);
    selected = dropOption ?? list.first;

    // selected değeri list içindeki bir öğe ile eşleşiyor mu kontrol edin
    if (selected != null && !list.contains(selected)) {
      selected = list.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);

    return DropdownButtonFormField<DropOption>(
      dropdownColor: CpColors.appbarColor,
      key: ctkey,
      value: selected,
      items: list
          .map(
            (e) => DropdownMenuItem<DropOption>(
          value: e,
          child: Row(
            children: [
              // Icon ve ad alanını özelleştirmek için
              Padding(
                padding: context.padding.onlyLeftLow,
                child: Text(e.optionTitle),
              ),
            ],
          ),
        ),
      )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selected = value;
        });

        // Durumu güncelleyin
        ref.read(currentDropOptionManager.notifier).changState(value);

        // Cache'i güncelleyin
        ref.read(currentCacheSetupManager.notifier).setCustomDropOption(
          ref,
          whichCustomDropOption: key,
          gameId: gameId,
          val: selected!,
        );
      },
      borderRadius: BorderRadius.circular(10),
    );
  }
}
