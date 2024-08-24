part of "middle_text_of_speech.dart";

mixin _MiddleTextOfSpeechMixin on ConsumerState<MiddleTextOfSpeech> {
  //Variables
  late AnimationController _animationController;
  late ScrollController _scrollController;
  late Animation<Offset> _slideAnimation;
  StreamSubscription? _playerSubscription;
  List<TextSpan> listOfSpan = [];

  //Functions

  Animation<Offset> slideAnimate() {
    return _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  Future<void> generateAndSave() async {

    await ref.read(currentAdmobManager.notifier).initializeAds(ref);

    ref.read(currentAdmobManager.notifier).show(ref);

    ref
        .read(currentMeetControllerManager.notifier)
        .createTodoListFromGpt(widget.customRef);
  }

  //Custom Decorations
  TextStyle textStateStyle() {
    return TextStyle(
      fontSize: 19.sp,
      fontFamily: ApplicationConstants.customFontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  BoxDecoration contentCoverDecoration() {
    return BoxDecoration(
      color: CustomColors.fillWhiteColor,
      borderRadius: CustomBorder.onlyBottomHugeRadius,
      boxShadow: const [
        BoxShadow(
          color: CustomColors.fillWhiteColor,
          spreadRadius: -6,
          blurRadius: 25,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  BoxDecoration contentDecoration() {
    return BoxDecoration(
      color: CustomColors.fillWhiteColor,
      borderRadius: CustomBorder.allHighRadius,
      boxShadow: const [
        BoxShadow(
          color: CustomColors.greyColor,
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.white,
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }

  EdgeInsets getPadding() {
    return EdgeInsets.only(
      bottom: EdgeExtension.hugeEdge.edgeValue,
      left: 4.w,
      right: 4.w,
    );
  }

  TextSpan buildTextSpan(
      {required String value,
      required int key,
      required WidgetRef ref,
      int? nextKey,
      int? previousKey,
      int? currentMillisecond}) {
    currentMillisecond = currentMillisecond != null
        ? (currentMillisecond ~/ 2).toInt()
        : currentMillisecond;

    return TextSpan(
        text: value,
        style: contentTextStyle(
            ref, nextKey, currentMillisecond, key, previousKey));
  }

  TextStyle contentTextStyle(WidgetRef ref, int? nextKey,
      int? currentMillisecond, int key, int? previousKey) {
    return TextStyle(
        fontSize: 19.sp,
        fontFamily: ApplicationConstants.customFontFamily,
        fontWeight: FontWeight.w400,
        color: (ref.watch(currentPlayerControlState) ==
                    CustomPlayerStates.listen &&
                nextKey != null &&
                currentMillisecond != null &&
                key > currentMillisecond &&
                currentMillisecond > previousKey!)
            ? CustomColors.fillWhiteColor
            : Colors.black,
        backgroundColor: (ref.watch(currentPlayerControlState) ==
                    CustomPlayerStates.listen &&
                nextKey != null &&
                currentMillisecond != null &&
                key > currentMillisecond &&
                currentMillisecond > previousKey!
            ? CustomColors.accentColor
            : Colors.transparent));
  }
}
