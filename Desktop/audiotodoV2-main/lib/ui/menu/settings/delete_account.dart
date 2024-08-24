import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/buttons/neu_stadium_button.dart';
import 'package:audiotodo/utilities/components/checks/basic_check.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteAccount extends ConsumerStatefulWidget {
  const DeleteAccount({
    super.key,
  });

  @override
  ConsumerState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends ConsumerState<DeleteAccount> {
  Map<String, String> reasonMap = {
    "settings_close_account_reason1": S.current.settings_close_account_reason1,
    "settings_close_account_reason2": S.current.settings_close_account_reason2,
    "settings_close_account_reason3": S.current.settings_close_account_reason3,
    "settings_close_account_reason4": S.current.settings_close_account_reason4,
    "settings_close_account_reason5": S.current.settings_close_account_reason5,
    "settings_close_account_reason6": S.current.settings_close_account_reason6,
    "settings_close_account_reason7": S.current.settings_close_account_reason7,
    "settings_close_account_reason8": S.current.settings_close_account_reason8,
    "settings_close_account_reason9": S.current.settings_close_account_reason9,
    "settings_close_account_reason10":
        S.current.settings_close_account_reason10,
    "settings_close_account_reason11":
        S.current.settings_close_account_reason11,
  };

  final Map<String, bool> _selectedReasons = {};

  @override
  void initState() {
    super.initState();

    reasonMap.forEach((key, value) {
      _selectedReasons[key] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(contentTitle: S.current.settings_close_account),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.settings_close_account_subtitle,
              style: ThemeValueExtension.subtitle,
            ),
            SizedBox(height: 4.h),
            Text(S.current.settings_close_account_explain),
            SizedBox(height: 4.h),
            Expanded(
                child: ListView(
              physics: const ClampingScrollPhysics(),
              children: _selectedReasons.keys.map((String reason) {
                return BasicCheck(
                  explain: reasonMap[reason]!,
                  onCheck: (bool checked) {
                    setState(() {
                      _selectedReasons[reason] = checked;
                    });
                  },
                );
              }).toList(),
            )),
            SizedBox(height: 8.h),
            Center(
              child: NeuStadiumTextButton(
                  forceColor: CustomColors.errorColor,
                  customWidth: 80.w,
                  text: S.current.settings_close_account_button,

                  onPressed: (){
                if (_selectedReasons.values.any((element) => element == true)) {
                  AuthDialogs.closeAccount(ref, _selectedReasons);
                } else {
                  //Snack bar from scaffold
                  final snackBar = SnackBar(
                    content: Text(S.current.settings_no_reason_snack_bar),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: S.current.settings_no_reason_snack_bar_undo,
                      onPressed: () {
                        //close snackbar
                      },
                    ),
                  );
                  // SnackBar's gösterme
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
