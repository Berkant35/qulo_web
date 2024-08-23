import 'dart:developer';

import 'package:catchpad/models/enums/game/game_end_type.dart';
import 'package:catchpad/models/enums/game/game_score_type.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game_result_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/services/email_verification_service.dart';
import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_textfield.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:catchpad/utils/widgets/textfields/email_verification_textfield.dart';
import 'package:catchpad/utils/widgets/textfields/profanity_textfield.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/enums/traces/play_traces_enum.dart';
import '../../../../utils/util_widgets/util_texts.dart';

class IgaRegisterPage extends ConsumerStatefulWidget {
  const IgaRegisterPage({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaRegisterPageState();
}

class _IgaRegisterPageState extends ConsumerState<IgaRegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isCreatedIgaUser = ValueNotifier(false);
  String _verificationResult = '';
  final EmailVerificationService _emailVerificationService =
      EmailVerificationService();

  Future<void> _verifyEmail(String email) async {
    final result = await _emailVerificationService.verifyEmail(email);
    inspect(result);
    setState(() {
      _verificationResult = result.toString();
    });
  }

  Country? _country;
  final langs = L10n.allLangModels();

  Future<void> checkProfanity() async {}


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   ref.read(currentSafeInGameToggleState.notifier).startPadShow(ref, [], forcedVal: true);
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    Future((){
      ref.read(appLangProv.notifier).setLanguage(langs[0]);
    });

    final result = GameResultModel(
        type: GameEndType.duration,
        gameId: '',
        accountHolderId: '',
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: null);

    ref.read(currentIgaTraceManager.notifier).isEnterRegister(isEnter: true);

    if (!ref.read(currentSafeInGameToggleState)) {
      Future(() {
        ref
            .read(currentSafeInGameToggleState.notifier)
            .changState(false, ref);
        ref
            .read(currentSafeInGameToggleState.notifier)
            .startPadShow(ref,[], forcedVal: true);
      });
    }

    final inst = L10n.inst(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(currentIgaPageManager.notifier)
                              .changState(IGAStates.home, ref: ref);
                        },
                        child: SizedBox(
                          width: 12.w,
                          height: 10.h,
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(currentIgaTraceManager.notifier)
                                  .refresh(ref: ref);

                              ref
                                  .read(currentIgaTraceManager.notifier)
                                  .createIgaTraceModel(ref: ref);

                              ref
                                  .read(currentIgaPageManager.notifier)
                                  .changState(IGAStates.onBoardingFour, ref: ref);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 64.px,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextLogoWidgetV2(
                        size: 5.h,
                      ),
                    ),
                    const Spacer(
                      flex: 9,
                    ),
                  ],
                ),
              ),
              Gap(1.h),

              SizedBox(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCpInfoTexts.seeLeaderboardToCompare(
                        inst.iga_see_leaderboard_to_compare, context),
                    Gap(1.h),
                    _enterUsernameText(context, inst, result),
                    _usernameTextfield(context, inst, result.gameId),
                    _enterEmailText(context, inst),
                    _emailTextfield(context, inst),
                    _enterCountryText(inst, context),
                    _pickCountry(context, inst),
                  ],
                ),
              ),
              Gap(2.h),
              // _ifRegisterBeforeInfo(inst, context),
              ValueListenableBuilder(
                  valueListenable: isCreatedIgaUser,
                  builder: (BuildContext context, bool isBusy, Widget? child) {
                    return !isBusy
                        ? Container(
                            width: 15.w,
                            height: 9.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 205, 255, 55),
                                  Color.fromARGB(255, 51, 255, 0)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  isCreatedIgaUser.value = true;
                                  isCreatedIgaUser.notifyListeners();

                                  await ref
                                      .read(currentIgaResultManager.notifier)
                                      .createIgaUserAndMatchCurrentResult(ref,
                                          email: _emailController.text,
                                          userName: _usernameController.text,
                                          country: _country?.name ?? "Türkiye",
                                          countryCode:
                                              _country?.countryCode ?? "TR")
                                      .then((value) {
                                    isCreatedIgaUser.value = false;
                                    isCreatedIgaUser.notifyListeners();

                                    if (value != null) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      ref
                                          .read(currentIgaPageManager.notifier)
                                          .changState(IGAStates.seeLeaderboard,
                                              ref: ref);
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                elevation: 0, // Gölgelendirme miktarı
                              ),
                              child: Text(inst.iga_next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _enterCountryText(AppLocalizations inst, BuildContext context) {
    return SizedBox(
      height: 4.5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            inst.iga_select_country,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: textColor()),
          ),
        ],
      ),
    );
  }

  Text _ifRegisterBeforeInfo(AppLocalizations inst, BuildContext context) {
    return Text(
      inst.iga_register_information,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: CpColors.cpPrimary.withOpacity(0.3), fontSize: 11.sp),
    );
  }

  Container _pickCountry(BuildContext context, AppLocalizations inst) {
    return Container(
        width: 50.w,
        decoration: BoxDecoration(
            color: CpColors.cpLead, borderRadius: BorderRadius.circular(18)),
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onTap: () {
              showCountryPicker(
                context: context,
                favorite: <String>[
                  'TR',
                ],
                showPhoneCode: false,
                onSelect: (Country country) {
                  setState(() {
                    _country = country;
                  });
                },
                countryListTheme: CountryListThemeData(
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                  backgroundColor: CpColors.cpLead,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  inputDecoration: InputDecoration(
                    labelText: inst.search,
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    hintText: '',
                    hintStyle: Theme.of(context).textTheme.labelLarge,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: CpColors.cpPrimary,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                  ),
                  searchTextStyle: const TextStyle(
                    color: CpColors.cpPrimary,
                    fontSize: 18,
                  ),
                ),
              );
            },
            leading: Text(
              Utils.countryCodeToEmoji(_country?.countryCode ?? 'TR'),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
            title: Text(
              _country?.displayNameNoCountryCode ?? 'Türkiye',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: CpColors.cpDavysGrey),
            ),
            trailing: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.yellow, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.white,
                size: 40.0,
              ),
            )));
  }

  Padding _pickCountryText(BuildContext context, AppLocalizations inst) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h, left: 1.w),
      child: Text(
        inst.iga_select_country,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }

  ProfanityTextfield _usernameTextfield(
      BuildContext context, AppLocalizations inst, String gameId) {
    return ProfanityTextfield(
        formkey: _formKey,
        controller: _usernameController,
        hintText: ((gameId ?? 's1') != 's4')
            ? inst.iga_username_hint
            : inst.iga_team_name,
        maxLength: 45,
        keyboardType: TextInputType.name);
  }

  EmailVerificationTextfield _emailTextfield(
      BuildContext context, AppLocalizations inst) {
    return EmailVerificationTextfield(
        formkey: _formKey,
        controller: _emailController,
        hintText: inst.iga_email_example,
        keyboardType: TextInputType.emailAddress);
  }

  Widget _enterUsernameText(
      BuildContext context, AppLocalizations inst, GameResultModel? result) {
    return SizedBox(
      height: 4.5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ((result?.gameId ?? 's1') != 's4')
                ? inst.iga_provide_username
                : inst.iga_team_name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: textColor()),
          ),
          Text(
            ((result?.gameId ?? 's1') != 's4')
                ? inst.iga_username_explanation
                : (inst.language.toLowerCase() == 'tr'
                    ? inst.iga_username_explanation
                        .replaceAll("Kullanıcı adın", "Takım adın")
                    : inst.iga_username_explanation
                        .replaceAll("username", "team name")),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 10.sp, color: textColor()),
          ),
        ],
      ),
    );
  }

  Widget _enterEmailText(BuildContext context, AppLocalizations inst) {
    return SizedBox(
      height: 4.5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            inst.iga_provide_email,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: textColor()),
          ),
          Text(
            inst.iga_email_explanation,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 10.sp, color: textColor()),
          ),
        ],
      ),
    );
  }

  Color textColor() => Colors.white.withOpacity(0.54);
}
