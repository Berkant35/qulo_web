part of 'iga_register.dart';

mixin _IgaRegisterPageMixin on  State<IgaRegisterPage>,ConsumerState<IgaRegisterPage>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isCreatedIgaUser = ValueNotifier(false);
  final langs = L10n.allLangModels();

  Country? _country;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();

    super.dispose();
  }
  void changeState() {
    Future(() {
      ref
          .read(currentIgaTraceStateManager.notifier)
          .changState(IgaPlayTraceStates.register, ref: ref);
    });
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
  Padding _backButton(GameResultModel? result) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                // if == s1 and first player not registered so currentIgaResult state == null
                // logger.i("İs there");
                ref.read(currentIgaResultManager.notifier).backFirstPlayerRegisterWorkStatus();
                logger.i("@@@@@@");

                if(result != null && result.gameId == 's1'
                    && ref.read(currentIgaResultManager) == null
                    && ref.read(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone)
                {
                  setState(() {
                    _usernameController.clear();
                    _emailController.clear();
                    _country = null;
                  });
                }

                FocusManager.instance.primaryFocus
                    ?.unfocus();
                ref
                    .read(currentIgaPageManager.notifier)
                    .changState(IGAStates.home, ref: ref);
              },
              child: SizedBox(
                width: 12.w,
                height: 10.h,
                child: IconButton(
                  onPressed: () {
                    logger.w(
                        "${(result != null && result.gameId == 's1'
                            && ref.read(currentIgaResultManager) == null
                            && ref.read(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone)} Result: ${result?.gameId} - ${ref.read(currentIgaResultManager)} - ${ref.read(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone}"
                    );
                    ref.read(currentIgaResultManager.notifier).backFirstPlayerRegisterWorkStatus();

                    logger.i("@@@@@@");
                    if(result != null && result.gameId == 's1'
                        && ref.watch(currentIgaResultManager)?.igaUserId == null
                        && ref.watch(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone && !ref.watch(currentIgaResultManager.notifier).firstPlayerRegistered)
                    {
                      ref.read(currentIgaResultManager.notifier).backFirstPlayerRegisterWorkStatus();
                      setState(() {
                        _usernameController.clear();
                        _emailController.clear();
                        _country = null;
                      });
                    }else{
                      ref
                          .read(currentIgaTraceManager.notifier)
                          .refresh(ref: ref);

                      ref
                          .read(currentIgaTraceManager.notifier)
                          .createIgaTraceModel(ref: ref);

                      ref
                          .read(currentIgaPageManager.notifier)
                          .changState(IGAStates.onBoardingFour, ref: ref);
                    }


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
    );
  }
  Text _ifRegisterBeforeInfo(AppLocalizations inst, BuildContext context) {
    return Text(
      inst.iga_register_information,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: CpColors.cpPrimary.withOpacity(0.3), fontSize: 11.sp),
    );
  }

  Form getPerPlayerForm(AppLocalizations inst, BuildContext context, GameResultModel? result) {
    final firstPlayerWork = ref.read(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone;
    logger.d("@@@$firstPlayerWork");
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(4.h),
          _backButton(result),
          Gap(1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(result?.gameId == 's1')
                Expanded(flex:2,child: SizedBox(
                  height: 15.h,child:  Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Which player
                      Container(
                        height: 8.h,
                        width: 8.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                              .withOpacity(0.04),
                        ),

                        child: Center(
                          child: Text(
                            "${(!ref.watch(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone ? "1" : "2")}.\n${inst.player}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color:
                              CpColors.cpBasicWhite,
                            ),
                          ),
                        ),
                      ),
                      Gap(1.5.w),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CpColors.cpBasicWhite,
                                width: 0.5
                            ),
                            borderRadius: const BorderRadius.horizontal(right: Radius.elliptical(24, 24),left: Radius.elliptical(24, 24)),
                          ),
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: ColorContainer(!ref.watch(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone ? result!.players.first.clrs.first : result!.players.last.clrs.first  ),
                          )),
                    ],
                  ),
                ),)),
              getInfoPlayer(inst, context, result),

              if(result!.gameId == 's1')
                const Spacer(flex: 2,)
            ],
          ),
          Gap(2.h),
          // _ifRegisterBeforeInfo(inst, context),
          sendInfoPlayer(inst,result),
        ],
      ),
    );
  }
  ValueListenableBuilder<bool> sendInfoPlayer(AppLocalizations inst,GameResultModel result) {
    return ValueListenableBuilder(
        valueListenable: isCreatedIgaUser,
        builder: (BuildContext context, bool isBusy, Widget? child) {
          return !isBusy
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if(!ref.watch(currentIgaResultManager.notifier).
              // firstPlayerRegisterWorkDone && result.gameId == 's1')
              // Container(
              //   width: 15.w,
              //   height: 9.h,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(32.0),
              //     color: Colors.white.withOpacity(0.9),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       ref.read(currentIgaResultManager.notifier)
              //           .setTrueFirstPlayerRegisterWorkStatus();
              //       setState(() {
              //         _usernameController.clear();
              //         _emailController.clear();
              //         _country = null;
              //       });
              //     },
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: Colors.black,
              //       backgroundColor: Colors.transparent,
              //       elevation: 0, // Gölgelendirme miktarı
              //     ),
              //     child: Text(inst.iga_skip,
              //         style: Theme.of(context)
              //             .textTheme
              //             .titleLarge!
              //             .copyWith(fontWeight: FontWeight.bold)),
              //   ),
              // ),
              // Gap(4.w),
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

                                //Check if game multiplayer game and secondplayer is null or
                                //if game is single player game
                                if ((result.gameId == 's1' && ref.read(currentIgaResultManager.notifier).firstPlayerRegisterWorkDone) || result.gameId != 's1') {
                                  ref.read(currentGiveRateManager.notifier).changeGameId(result.gameId);
                                  ref.read(currentGiveRateManager.notifier).changState(true);
                                  ref.read(currentIgaPageManager.notifier).changState(IGAStates.seeLeaderboard, ref: ref);
                                }
                                ref.read(currentIgaResultManager.notifier).setTrueFirstPlayerRegisterWorkStatus();
                                setState(() {
                                  _usernameController.clear();
                                  _emailController.clear();
                                  _country = null;
                                });


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
                }
              ),

            ],
          )
              : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }

  Widget getInfoPlayer(AppLocalizations inst, BuildContext context, GameResultModel? result) {
    return SizedBox(
      width: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(2.h),
          CustomCpInfoTexts.seeLeaderboardToCompare(
              inst.iga_see_leaderboard_to_compare, context),
          Gap(2.h),
          _enterUsernameText(context, inst, result),
          _usernameTextfield(context, inst, result!.gameId),
          _enterEmailText(context, inst),
          _emailTextfield(context, inst),
          _enterCountryText(inst, context),
          _pickCountry(context, inst),
        ],
      ),
    );
  }


  Color textColor() => Colors.white.withOpacity(0.54);
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

  Widget _usernameTextfield(
      BuildContext context, AppLocalizations inst, String gameId) {
    return SizedBox(
        width: 50.w,
        height: 15.h,
        child: ProfanityTextfield(
            formkey: _formKey,
            controller: _usernameController,
            hintText: ((gameId ?? 's1') != 's4')
                ? inst.iga_username_hint
                : inst.iga_team_name,
            maxLength: 45,
            keyboardType: TextInputType.name));
  }

  Widget _emailTextfield(BuildContext context, AppLocalizations inst) {
    return SizedBox(
        width: 50.w,
        height: 15.h,
        child: EmailVerificationTextfield(
            formkey: _formKey,
            controller: _emailController,
            hintText: inst.iga_email_example,
            keyboardType: TextInputType.emailAddress));
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
}