import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/flags_prov.dart';
import 'package:catchpad/prov/game_result_prov.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_textfield.dart';
import 'package:catchpad/utils/widgets/emb/iga/iga_util_widgets/color_selector.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:catchpad/utils/widgets/textfields/email_verification_textfield.dart';
import 'package:catchpad/utils/widgets/textfields/profanity_textfield.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/enums/traces/play_traces_enum.dart';
import '../../../../../prov/global_providers.dart';
import '../../../../../utils/util_widgets/util_texts.dart';

part 'iga_register_mixin.dart';

final class IgaRegisterPage extends ConsumerStatefulWidget {
  const IgaRegisterPage({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaRegisterPageState();
}

class _IgaRegisterPageState extends ConsumerState<IgaRegisterPage>
    with _IgaRegisterPageMixin {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(gameResultProv);

    ref.read(currentIgaTraceManager.notifier).isEnterRegister(isEnter: true);

    changeState();

    final inst = L10n.inst(context);

    return SingleChildScrollView(
      child: getPerPlayerForm(inst, context, result),
    );
  }
}
