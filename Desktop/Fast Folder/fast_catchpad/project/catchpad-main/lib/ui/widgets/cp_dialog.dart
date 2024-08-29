import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/auth/register_user.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/cp_colors.dart';
import '../../utils/text_field_borders.dart';
import '../../utils/utils.dart';
import 'buttons/cp_button_1.dart';
import 'buttons/cp_button_3.dart';

class CatchpadDialog extends StatelessWidget {
  final String? title;
  final String? content;

  final VoidCallback? action1;
  final String? action1Text;

  final VoidCallback? action2;
  final String? action2Text;

  const CatchpadDialog({
    this.title,
    this.content,
    this.action1,
    this.action1Text,
    this.action2,
    this.action2Text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CpColors.dialogBgColor,
      title: title != null
          ? Center(
              child: Text(title!),
            )
          : null,
      content: content != null ? Text(content!) : null,
      actions: [
        if (action1Text != null)
          CpButton1(
            onPressed: action1,
            fullWidth: true,
            child: Text(action1Text!),
          ),
        if (action2Text != null)
          CpButton3(
            onPressed: action2,
            fullWidth: true,
            child: Text(action2Text!),
          ),
      ].joinWidgetList(
        (e) => const SizedBox(height: defPaddingSize),
      ),
    );
  }
}

class CatchPadFeedBackDialog {
  static final formFeedBackKey = GlobalKey<FormState>();



  static void feedBackDialogAboutGame(String gameId, WidgetRef ref) {
    final inst = L10n.inst(ref.context);
    final currentUser = ref.read(currentUserProv);
    var textEditingController = TextEditingController();
    double lValue = 0;
    AwesomeDialog awesomeDialog = AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.infoReverse,
        animType: AnimType.bottomSlide,
        title: inst.game_feed_back,
        body: Form(
          key: formFeedBackKey,
          child: Column(
            children: [
              CustomRatingStars(
                callBack: (val) {
                  lValue = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: defPaddingSize, top: defPaddingSize),
                child: TextFormField(
                  validator: (value) =>
                      (value!.isEmpty) ? inst.classes_screen_empty_field : null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.getDynamicDecoration(
                      inst.game_feed_back),
                  controller: textEditingController,
                ),
              )
            ],
          ),
        ),
        btnOkText: inst.ok,
        btnOkOnPress: () {
          formFeedBackKey.currentState!.save();
          if (formFeedBackKey.currentState!.validate()) {
            var feedBack = FeedBack(
                registerUser: currentUser!,
                feedBackDetail: textEditingController.text,
                createdTime: DateTime.now().toString(),
                pointFromFive: lValue.toInt(),
                gameId: gameId);

            FirebaseCollectionEnums.game_feed_back.reference
                .doc(gameId)
                .collection("users")
                .doc(feedBack.registerUser.uid!)
                .set(feedBack.toJson());
          }
        });

    awesomeDialog.show();
  }

  static void notAcceptedPolicy(WidgetRef ref) {
    final inst = L10n.inst(ref.context);

    AwesomeDialog awesomeDialog = AwesomeDialog(
      context: ref.context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: inst.not_accepted_privacy,
      btnOkText: inst.ok,
    );

    awesomeDialog.show();
  }
}

class CustomRatingStars extends StatefulWidget {
  final Function(double value) callBack;

  const CustomRatingStars({super.key, required this.callBack});

  @override
  State<CustomRatingStars> createState() => _CustomRatingStarsState();
}

class _CustomRatingStarsState extends State<CustomRatingStars> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: value,
      onValueChanged: (v) {
        value = v;
        value.toInt();
        setState(() {});
        widget.callBack(v);
      },
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      starCount: 5,
      starSize: 20,
      valueLabelColor: CpColors.cpBg,
      valueLabelTextStyle: Theme.of(context).textTheme.titleSmall!,
      valueLabelRadius: 10,
      maxValue: 5,
      starSpacing: 2,
      maxValueVisibility: true,
      valueLabelVisibility: true,
      animationDuration: const Duration(milliseconds: 1000),
      starOffColor: const Color(0xffe7e8ea),
      starColor: CpColors.yellow,
    );
  }
}

class FeedBack {
  final RegisterUser registerUser;
  final String feedBackDetail;
  final int pointFromFive;
  final String createdTime;
  final String gameId;

  FeedBack({
    required this.registerUser,
    required this.feedBackDetail,
    required this.createdTime,
    required this.pointFromFive,
    required this.gameId,
  });

  factory FeedBack.fromJson(Map<String, dynamic> json) => FeedBack(
        registerUser: RegisterUser.fromJson(json['registerUser']),
        feedBackDetail: json['feedBackDetail'],
        createdTime: json['createdTime'],
        pointFromFive: json['pointFromFive'],
        gameId: json['gameId'],
      );

  Map<String, dynamic> toJson() => {
        'registerUser': registerUser.toJson(),
        'feedBackDetail': feedBackDetail,
        'createdTime': createdTime,
        'pointFromFive': pointFromFive,
        'gameId': gameId,
      };
}
