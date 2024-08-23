part of 'single_player_setup_widget.dart';

class _SinglePlayerNameSetupWidget extends ConsumerStatefulWidget {
  /// if null, means this is a general player
  final String id;

  const _SinglePlayerNameSetupWidget({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<_SinglePlayerNameSetupWidget> createState() =>
      _SinglePlayerSetupWidgetNameState();
}

class _SinglePlayerSetupWidgetNameState
    extends ConsumerState<_SinglePlayerNameSetupWidget> {
  String get id => widget.id;

  setPlayer(PlayerModel pl) =>
      ref.read(selectedPlayersProv.notifier).setPlayer(pl,currentDevCount: pl.devCount);

  bool anyOtherUserHasThisUid(String? uid) {
    return ref.watch(selectedPlayersProv).players.any(
          (element) => element.user != null && element.user!.uid == uid,
        );
  }

  bool isSettableToUserUid(String? uid) {
    return uid == null || !anyOtherUserHasThisUid(uid);
  }

  bool isSettableToUser(RegisterUser? user) {
    return isSettableToUserUid(user?.uid);
  }

  bool isUserMe(RegisterUser? user) {
    return user != null && user.uid == readCurrentUser?.uid;
  }

  bool setPlayerToDefault() {
    setPlayer(
      player.copyWith(name: '${L10n.inst(context).player} ${player.id}'),
    );

    nameFieldController!.text =
        player.playerName ?? player.user?.userName ?? '';

    return true;
  }

  bool setToInfoOfUser(RegisterUser? user) {
    if (!isSettableToUser(user)) {
      return false;
    }

    if (isUserMe(user)) {
      useMyUserInfo = true;
    }

    if(ref.watch(selectedPlayersProv)[id] != null){
      setPlayer(
        player.copyWith(user: user),
      );
    }else{
      return false;
    }
    nameFieldController!.text = player.playerName ?? user?.userName ?? '';
    return true;
  }

  RegisterUser? get currentUser =>
      // FirebaseAuth.instance.currentUser;
      ref.watch(currentUserProv);

  RegisterUser? get readCurrentUser => ref.read(currentUserProv);

  bool get isSettableToCurrentUser => isSettableToUserUid(currentUser?.uid);

  bool get thisIsTheCurrentUser => player.user?.uid == currentUser?.uid;

  bool get isSetToTest => player.user?.uid == cpTestUser.uid;

  bool emptyPlayer() {
    return setToInfoOfUser(null);
  }

  final cpTestUser = RegisterUser(
    userName: 'Main Player',
    fName: 'CatchPad',
    lName: 'Player',
    createdAt: DateTime(2020, 7, 4, 12, 0, 0),
  );

  /* final cpTestUser = RegisterUser(
    userName: 'MACFit',
    fName: 'MAC',
    lName: 'Fit',
    createdAt: DateTime(2022, 9, 14, 12, 0, 0),
  ); */

  final manualPlayer = RegisterUser(
    userName: '',
    fName: 'CatchPad',
    lName: 'Player',
    createdAt: DateTime(2020, 7, 4, 12, 0, 0),
  );

  Future<bool> setToLoggedinUserInfo() async {
    // final loggedinUser = currentUser;

    // if (loggedinUser == null) {
    //   assert(false);
    //   return false;
    // }

    // final user = await UsersApi.instance.getUserFromUserId(loggedinUser.uid);

    // we wanna assign the logged in player OR if not logged in
    // we wanna assign a fake (but real, it is registered on firestore)
    // player to the 1ST PLAYER. that's why we're doing anyOtherUserHasThisUid
    // because we do not wanna assign a fake player to more than one player.
    var user = readCurrentUser;

    if (readCurrentUser == null) {
      if (!anyOtherUserHasThisUid(cpTestUser.uid)) {
        user = cpTestUser;
      }
    }

    return setToInfoOfUser(user);
  }

  bool useMyUserInfo = true;

  SelectedPlayerModel get selectedPlayer {
    return ref.watch(selectedPlayersProv)[id]!;
  }

  PlayerModel get player {
    final pl = selectedPlayer.player;
    return pl;
  }

  StagedPlayerModel get staged {
    return selectedPlayer.staged;
  }

  TextEditingController? nameFieldController;
  late AppLocalizations inst;

  @override
  void initState() {
    super.initState();
    cpTestUser.uid = cpTestUser.userName;
    nameFieldController = TextEditingController();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        // we wanna set the first player's name to the logged in,
        // and the others' to Player 1, Player 2, etc.
        final setToLoggeedIn = await setToLoggedinUserInfo();

        if (!setToLoggeedIn) {
          //setPlayerToDefault();
        }

        nameFieldController?.text = widget.id == '1'
            ? ref.read(currentUserProv)?.fName ?? "-"
            : "${widget.id}. ${inst.player}";
        manualPlayer.userName = nameFieldController!.text;
        /* if (value.isEmpty) {
                manualPlayer.userName = '${players.length}. ${inst.player}';
              } */
        if (ref.watch(selectedPlayersProv)[id] == null || player == null) return;
        setPlayer(
          player.copyWith(name: nameFieldController!.text, user: manualPlayer),
        );
      },
    );
  }

  Future<void> stateSetPlayerFunction() async {
    {
      // we wanna set the first player's name to the logged in,
      // and the others' to Player 1, Player 2, etc.
      final setToLoggeedIn = await setToLoggedinUserInfo();

      if (!setToLoggeedIn) {
        //setPlayerToDefault();
      }else{
        nameFieldController?.text = widget.id == '1'
            ? ref.read(currentUserProv)?.fName ?? "-"
            : "${widget.id}. ${inst.player}";
        manualPlayer.userName = nameFieldController!.text;
        /* if (value.isEmpty) {
                   manualPlayer.userName = '${players.length}. ${inst.player}';
                 } */
        if (player != null) {
          setPlayer(
            player.copyWith(name: nameFieldController!.text, user: manualPlayer),
          );
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future(() {
      stateSetPlayerFunction();
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameFieldController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inst = L10n.inst(context);
    nameFieldController ??= TextEditingController();
    cpTestUser.lName = inst.player;
    cpTestUser.userName = inst.main_player;


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextFormField(
            controller: nameFieldController,
            autofocus: ref.watch(selectedPlayersProv).length > 2 ? true : false,
            onChanged: (value) {
              manualPlayer.userName = value;
              /* if (value.isEmpty) {
                manualPlayer.userName = '${players.length}. ${inst.player}';
              } */
              setPlayer(
                player.copyWith(
                    name: nameFieldController!.text, user: manualPlayer),
              );
            },
            onEditingComplete: () {
              manualPlayer.userName = nameFieldController!.text;
              manualPlayer.uid = nameFieldController!.text;
              setPlayer(
                player.copyWith(
                    name: nameFieldController!.text, user: manualPlayer),
              );
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: '${widget.id}. ${inst.player}',
              suffixIcon: IconButton(
                  onPressed: () async {
                    final groupPlayers =
                        ref.watch(selectedClassProvider)?.students ?? [];

                    if (groupPlayers.isEmpty) {
                      final okcancelresult = await showOkCancelAlertDialog(
                        context: context,
                        title: inst.add_go_to_groups_screen,
                        style: AdaptiveStyle.adaptive,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor: CpColors.cpBg,
                            ),
                            child:
                                Container(color: CpColors.bgGC2, child: child),
                          );
                        },
                      );
                      if (okcancelresult == OkCancelResult.ok) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClassesScreen(),
                            ));
                        return;
                      }
                      if (okcancelresult == OkCancelResult.cancel) {
                        return;
                      }
                    }
                    groupPlayers.sort(
                      (a, b) => b.createdAt.compareTo(a.createdAt),
                    );
                    final searchController = TextEditingController();
                    await showDialog(
                      context: context,
                      builder: (context) {
                        IconData filter = Icons.date_range;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Material(
                              child: Container(
                                color: CpColors.bgGC2,
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, right: 4),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                        Icons.arrow_back)),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (filter ==
                                                            Icons
                                                                .sort_by_alpha) {
                                                          filter =
                                                              Icons.date_range;
                                                          groupPlayers.sort(
                                                            (a, b) => b
                                                                .createdAt
                                                                .compareTo(a
                                                                    .createdAt),
                                                          );
                                                        } else {
                                                          filter = Icons
                                                              .sort_by_alpha;
                                                          groupPlayers.sort(
                                                            (a, b) => a
                                                                .firstName
                                                                .compareTo(b
                                                                    .firstName),
                                                          );
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(filter)),
                                                CpBtnWithIcon(
                                                    border: Border.all(
                                                        color: Colors.white70,
                                                        width: 1.25),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      ref
                                                          .read(classProvider
                                                              .notifier)
                                                          .removeClass(ref,
                                                              className:
                                                                  'uniqallusersdevcode');
                                                      ref
                                                          .read(classProvider
                                                              .notifier)
                                                          .checkAndLoad(
                                                              ref, context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ClassesScreen(),
                                                          ));
                                                    },
                                                    icon: const Icon(
                                                        Icons.group_add),
                                                    child: Text(
                                                      inst.add_go_to_groups_screen,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ))
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: defPaddingSize),
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      searchController.clear();
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.clear))),
                                          ),
                                        ),
                                        ...groupPlayers
                                            .where((player) {
                                              return player.studentNickName
                                                  .toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase());
                                            })
                                            .toList()
                                            .map((e) => ListTile(
                                                  onTap: () {
                                                    setToInfoOfUser(RegisterUser(
                                                        userName:
                                                            e.studentNickName,
                                                        uid: e.studentNickName,
                                                        fName: e.firstName,
                                                        lName: e.lastName,
                                                        phoneNum:
                                                            e.studentNumber));
                                                    Navigator.pop(context);
                                                  },
                                                  leading:
                                                      const Icon(Icons.person),
                                                  title:
                                                      Text(e.studentNickName),
                                                  subtitle: Text(
                                                      '${e.firstName} ${e.lastName}'),
                                                ))
                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                      },
                    );
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  icon: const Icon(Icons.arrow_downward)),
            ),
          ),
        ),
      ],
    );
  }
}

class _SinglePlayerNameSetupWidgetV2 extends ConsumerStatefulWidget {
  /// if null, means this is a general player
  final String id;

  const _SinglePlayerNameSetupWidgetV2({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<_SinglePlayerNameSetupWidgetV2> createState() =>
      _SinglePlayerNameSetupWidgetV2NameState();
}

class _SinglePlayerNameSetupWidgetV2NameState
    extends ConsumerState<_SinglePlayerNameSetupWidgetV2> {
  String get id => widget.id;

  setPlayer(PlayerModel pl) =>
      ref.read(selectedPlayersProv.notifier).setPlayer(pl,currentDevCount: pl.devCount);

  bool anyOtherUserHasThisUid(String? uid) {
    return ref.watch(selectedPlayersProv).players.any(
          (element) => element.user != null && element.user!.uid == uid,
        );
  }

  bool isSettableToUserUid(String? uid) {
    return uid == null || !anyOtherUserHasThisUid(uid);
  }

  bool isSettableToUser(RegisterUser? user) {
    return isSettableToUserUid(user?.uid);
  }

  bool isUserMe(RegisterUser? user) {
    return user != null && user.uid == readCurrentUser?.uid;
  }

  bool setPlayerToDefault() {
    setPlayer(
      player.copyWith(name: '${L10n.inst(context).player} ${player.id}'),
    );

    nameFieldController!.text =
        player.playerName ?? player.user?.userName ?? '';

    return true;
  }

  bool setToInfoOfUser(RegisterUser? user) {
    if (!isSettableToUser(user)) {
      return false;
    }

    if (isUserMe(user)) {
      useMyUserInfo = true;
    }

    setPlayer(
      player.copyWith(user: user),
    );

    nameFieldController!.text = player.playerName ?? user?.userName ?? '';

    return true;
  }

  RegisterUser? get currentUser =>
      // FirebaseAuth.instance.currentUser;
      ref.watch(currentUserProv);

  RegisterUser? get readCurrentUser => ref.read(currentUserProv);

  bool get isSettableToCurrentUser => isSettableToUserUid(currentUser?.uid);

  bool get thisIsTheCurrentUser => player.user?.uid == currentUser?.uid;

  bool get isSetToTest => player.user?.uid == cpTestUser.uid;

  bool emptyPlayer() {
    return setToInfoOfUser(null);
  }

  final cpTestUser = RegisterUser(
    userName: 'Main Player',
    fName: 'CatchPad',
    lName: 'Player',
    createdAt: DateTime(2020, 7, 4, 12, 0, 0),
  );

  /* final cpTestUser = RegisterUser(
    userName: 'MACFit',
    fName: 'MAC',
    lName: 'Fit',
    createdAt: DateTime(2022, 9, 14, 12, 0, 0),
  ); */

  final manualPlayer = RegisterUser(
    userName: '',
    fName: 'CatchPad',
    lName: 'Player',
    createdAt: DateTime(2020, 7, 4, 12, 0, 0),
  );

  Future<bool> setToLoggedinUserInfo() async {
    // final loggedinUser = currentUser;

    // if (loggedinUser == null) {
    //   assert(false);
    //   return false;
    // }

    // final user = await UsersApi.instance.getUserFromUserId(loggedinUser.uid);

    // we wanna assign the logged in player OR if not logged in
    // we wanna assign a fake (but real, it is registered on firestore)
    // player to the 1ST PLAYER. that's why we're doing anyOtherUserHasThisUid
    // because we do not wanna assign a fake player to more than one player.
    var user = readCurrentUser;

    if (readCurrentUser == null) {
      if (!anyOtherUserHasThisUid(cpTestUser.uid)) {
        user = cpTestUser;
      }
    }

    return setToInfoOfUser(user);
  }

  bool useMyUserInfo = true;

  SelectedPlayerModel get selectedPlayer {
    return ref.watch(selectedPlayersProv)[id]!;
  }

  PlayerModel get player {
    final pl = selectedPlayer.player;
    return pl;
  }

  StagedPlayerModel get staged {
    return selectedPlayer.staged;
  }

  TextEditingController? nameFieldController;
  late AppLocalizations inst;

  @override
  void initState() {
    super.initState();
    cpTestUser.uid = cpTestUser.userName;
    nameFieldController = TextEditingController();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        // we wanna set the first player's name to the logged in,
        // and the others' to Player 1, Player 2, etc.
        final setToLoggeedIn = await setToLoggedinUserInfo();
        if (!setToLoggeedIn) {
          //setPlayerToDefault();
        }

        nameFieldController?.text = widget.id == '1'
            ? ref.read(currentUserProv)?.fName ?? "-"
            : "${widget.id}. ${inst.player}";
        manualPlayer.userName = nameFieldController!.text;
        /* if (value.isEmpty) {
                manualPlayer.userName = '${players.length}. ${inst.player}';
              } */
        setPlayer(
          player.copyWith(name: nameFieldController!.text, user: manualPlayer),
        );
      },
    );
  }

  Future<void> stateSetPlayerFunction() async {
    {
      // we wanna set the first player's name to the logged in,
      // and the others' to Player 1, Player 2, etc.
      final setToLoggeedIn = await setToLoggedinUserInfo();
      if (!setToLoggeedIn) {
        //setPlayerToDefault();
      }

      nameFieldController?.text = widget.id == '1'
          ? ref.read(currentUserProv)?.fName ?? "-"
          : "${widget.id}. ${inst.player}";
      manualPlayer.userName = nameFieldController!.text;
      /* if (value.isEmpty) {
                   manualPlayer.userName = '${players.length}. ${inst.player}';
                 } */
      setPlayer(
        player.copyWith(name: nameFieldController!.text, user: manualPlayer),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future(() {
      stateSetPlayerFunction();
    });
  }

  @override
  void dispose() {
    nameFieldController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inst = L10n.inst(context);
    nameFieldController ??= TextEditingController();
    cpTestUser.lName = inst.player;
    cpTestUser.userName = inst.main_player;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextFormField(
            controller: nameFieldController,
            autofocus: ref.watch(selectedPlayersProv).length > 2 ? true : false,
            onChanged: (value) {
              manualPlayer.userName = value;
              /* if (value.isEmpty) {
                manualPlayer.userName = '${players.length}. ${inst.player}';
              } */
              setPlayer(
                player.copyWith(
                    name: nameFieldController!.text, user: manualPlayer),
              );
            },
            onEditingComplete: () {
              manualPlayer.userName = nameFieldController!.text;
              manualPlayer.uid = nameFieldController!.text;
              setPlayer(
                player.copyWith(
                    name: nameFieldController!.text, user: manualPlayer),
              );
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: '${widget.id}. ${inst.player}',
              suffixIcon: IconButton(
                  onPressed: () async {
                    final groupPlayers =
                        ref.watch(selectedClassProvider)?.students ?? [];

                    if (groupPlayers.isEmpty) {
                      final okcancelresult = await showOkCancelAlertDialog(
                        context: context,
                        title: inst.add_go_to_groups_screen,
                        style: AdaptiveStyle.adaptive,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor: CpColors.cpBg,
                            ),
                            child:
                                Container(color: CpColors.bgGC2, child: child),
                          );
                        },
                      );
                      if (okcancelresult == OkCancelResult.ok) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClassesScreen(),
                            ));
                        return;
                      }
                      if (okcancelresult == OkCancelResult.cancel) {
                        return;
                      }
                    }
                    groupPlayers.sort(
                      (a, b) => b.createdAt.compareTo(a.createdAt),
                    );
                    final searchController = TextEditingController();
                    await showDialog(
                      context: context,
                      builder: (context) {
                        IconData filter = Icons.date_range;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Material(
                              child: Container(
                                color: CpColors.bgGC2,
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, right: 4),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                        Icons.arrow_back)),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (filter ==
                                                            Icons
                                                                .sort_by_alpha) {
                                                          filter =
                                                              Icons.date_range;
                                                          groupPlayers.sort(
                                                            (a, b) => b
                                                                .createdAt
                                                                .compareTo(a
                                                                    .createdAt),
                                                          );
                                                        } else {
                                                          filter = Icons
                                                              .sort_by_alpha;
                                                          groupPlayers.sort(
                                                            (a, b) => a
                                                                .firstName
                                                                .compareTo(b
                                                                    .firstName),
                                                          );
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(filter)),
                                                CpBtnWithIcon(
                                                    border: Border.all(
                                                        color: Colors.white70,
                                                        width: 1.25),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      ref
                                                          .read(classProvider
                                                              .notifier)
                                                          .removeClass(ref,
                                                              className:
                                                                  'uniqallusersdevcode');
                                                      ref
                                                          .read(classProvider
                                                              .notifier)
                                                          .checkAndLoad(
                                                              ref, context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ClassesScreen(),
                                                          ));
                                                    },
                                                    icon: const Icon(
                                                        Icons.group_add),
                                                    child: Text(
                                                      inst.add_go_to_groups_screen,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ))
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: defPaddingSize),
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      searchController.clear();
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.clear))),
                                          ),
                                        ),
                                        ...groupPlayers
                                            .where((player) {
                                              return player.studentNickName
                                                  .toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase());
                                            })
                                            .toList()
                                            .map((e) => ListTile(
                                                  onTap: () {
                                                    setToInfoOfUser(RegisterUser(
                                                        userName:
                                                            e.studentNickName,
                                                        uid: e.studentNickName,
                                                        fName: e.firstName,
                                                        lName: e.lastName,
                                                        phoneNum:
                                                            e.studentNumber));
                                                    Navigator.pop(context);
                                                  },
                                                  leading:
                                                      const Icon(Icons.person),
                                                  title:
                                                      Text(e.studentNickName),
                                                  subtitle: Text(
                                                      '${e.firstName} ${e.lastName}'),
                                                ))
                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                      },
                    );
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  icon: const Icon(Icons.arrow_downward)),
            ),
          ),
        ),
      ],
    );
  }
}
