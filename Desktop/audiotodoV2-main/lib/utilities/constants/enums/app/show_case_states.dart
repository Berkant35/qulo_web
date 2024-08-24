import 'package:audiotodo/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

enum ShowCaseStates {
  startMeeting,
  playOrPause,
  speechToText,
  doneMeet,
  goReview,
  reviewGenerateAndSave,
  // waitingResponse,
  resultSummary,
  resultPureText,
  // resultRegenerate,
  resultToDos,
  resultToDoCards,
  resultAssignedPersons,
  // resultAssignedDragAndDrop,
  resultAddOrRemove,
  resultAddDate,

  resultButtonsOffice,
  // resultButtonsOfficeExplain,
  resultButtonThirdParty,
  // resultButtonThirdPartyExplain,
  resultButtonRateUs,
  // resultButtonRateUsExplain,
  resultButtonFinish,
  allMeets;

  ShapeBorder getShapeBorder() {
    switch (this) {
      case ShowCaseStates.startMeeting:
        return const CircleBorder();
      case ShowCaseStates.playOrPause:
        return const CircleBorder();
      case ShowCaseStates.speechToText:
        return  const StadiumBorder();
      case ShowCaseStates.doneMeet:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      // case ShowCaseStates.reviewCancel:
      //   return const CircleBorder();
      case ShowCaseStates.reviewGenerateAndSave:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      case ShowCaseStates.resultSummary:
        return  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      case ShowCaseStates.resultPureText:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      // case ShowCaseStates.resultRegenerate:
      //   return RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.px)),
      //   );
      case ShowCaseStates.resultToDos:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      case ShowCaseStates.resultToDoCards:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      case ShowCaseStates.resultAssignedPersons:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      // case ShowCaseStates.resultAssignedDragAndDrop:
      //   return RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.px)),
      //   );
      case ShowCaseStates.resultAddOrRemove:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );

      case ShowCaseStates.resultAddDate:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.px)),
        );
      case ShowCaseStates.resultButtonsOffice:
        return const CircleBorder();
      // case ShowCaseStates.resultButtonsOfficeExplain:
      //   return RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.px)),
      //   );
      case ShowCaseStates.resultButtonThirdParty:
        return const CircleBorder();
      // case ShowCaseStates.resultButtonThirdPartyExplain:
      //   return RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.px)),
      //   );
      case ShowCaseStates.resultButtonRateUs:
        return const CircleBorder();
      // case ShowCaseStates.resultButtonRateUsExplain:
      //   return RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.px)),
      //   );
      case ShowCaseStates.resultButtonFinish:
        return const CircleBorder();
      case ShowCaseStates.allMeets:
        return const CircleBorder();
      case ShowCaseStates.goReview:
        return const CircleBorder();



    }
  }

  TooltipPosition getTooltipPosition() {
    switch (this) {
      case ShowCaseStates.startMeeting:
        return TooltipPosition.bottom;
      case ShowCaseStates.playOrPause:
        return TooltipPosition.bottom;
      case ShowCaseStates.speechToText:
        return TooltipPosition.top;
      case ShowCaseStates.doneMeet:
        return TooltipPosition.top;
      // case ShowCaseStates.reviewCancel:
      //   return TooltipPosition.bottom;
      case ShowCaseStates.reviewGenerateAndSave:
        return TooltipPosition.top;
      case ShowCaseStates.resultSummary:
        return TooltipPosition.bottom;
      case ShowCaseStates.resultPureText:
        return TooltipPosition.top;
      // case ShowCaseStates.resultRegenerate:
      //   return TooltipPosition.top;
      case ShowCaseStates.resultToDos:
        return TooltipPosition.top;
      case ShowCaseStates.resultToDoCards:
        return TooltipPosition.top;
      case ShowCaseStates.resultAssignedPersons:
        return TooltipPosition.bottom;
      // case ShowCaseStates.resultAssignedDragAndDrop:
      //   return TooltipPosition.bottom;
      case ShowCaseStates.resultAddOrRemove:
        return TooltipPosition.bottom;

      case ShowCaseStates.resultButtonsOffice:
        return TooltipPosition.top;
      // case ShowCaseStates.resultButtonsOfficeExplain:
      //   return TooltipPosition.top;
      case ShowCaseStates.resultButtonThirdParty:
        return TooltipPosition.top;
      // case ShowCaseStates.resultButtonThirdPartyExplain:
      //   return TooltipPosition.top;
      case ShowCaseStates.resultButtonRateUs:
        return TooltipPosition.top;
      // case ShowCaseStates.resultButtonRateUsExplain:
      //   return TooltipPosition.top;
      case ShowCaseStates.resultButtonFinish:
        return TooltipPosition.top;
      case ShowCaseStates.allMeets:
        return TooltipPosition.bottom;
      case ShowCaseStates.goReview:
        return TooltipPosition.top;
      case ShowCaseStates.resultAddDate:
        return TooltipPosition.bottom;





    }
  }

  EdgeInsets getEdgeInsets() {
    switch (this) {
      case ShowCaseStates.startMeeting:
        return EdgeInsets.all(2.w);
      case ShowCaseStates.playOrPause:
        return EdgeInsets.all(2.w);
      case ShowCaseStates.speechToText:
        return EdgeInsets.all(2.w);
      case ShowCaseStates.doneMeet:
        return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.reviewCancel:
      //   return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.reviewGenerateAndSave:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultSummary:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultPureText:
        return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.resultRegenerate:
      //   return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultToDos:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultToDoCards:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultAssignedPersons:
        return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.resultAssignedDragAndDrop:
      //   return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultAddOrRemove:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultButtonsOffice:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultButtonThirdParty:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultButtonRateUs:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.resultButtonFinish:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.allMeets:
        return EdgeInsets.only(bottom: 50);
      case ShowCaseStates.goReview:
        return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.waitingResponse:
      //   return EdgeInsets.all(2.w);

      case ShowCaseStates.resultAddDate:
        return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.resultButtonsOfficeExplain:
      //   return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.resultButtonThirdPartyExplain:
      //   return EdgeInsets.only(bottom: 50);
      // case ShowCaseStates.resultButtonRateUsExplain:
      //   return EdgeInsets.only(bottom: 50);
    }
  }

  String getCurrentShowCaseDescription() {
    switch (this) {
      case ShowCaseStates.startMeeting:
        return S.current.tips_startMeeting;
      case ShowCaseStates.playOrPause:
        return S.current.tips_playOrPause;
      case ShowCaseStates.speechToText:
        return S.current.tips_speechToText;
      case ShowCaseStates.doneMeet:
        return S.current.tips_doneMeet;
      // case ShowCaseStates.reviewCancel:
      //   return S.current.tips_reviewCancel;
      case ShowCaseStates.reviewGenerateAndSave:
        return S.current.tips_reviewGenerateAndSave;
      case ShowCaseStates.resultSummary:
        return S.current.tips_resultSummary;
      case ShowCaseStates.resultPureText:
        return S.current.tips_resultPureText;
      // case ShowCaseStates.resultRegenerate:
      //   return S.current.tips_resultRegenerate;
      case ShowCaseStates.resultToDos:
        return S.current.tips_resultToDos;
      case ShowCaseStates.resultToDoCards:
        return S.current.tips_resultToDoCards;
      case ShowCaseStates.resultAssignedPersons:
        return S.current.tips_resultAssignedPersons;
      case ShowCaseStates.resultAddDate:
        return S.current.tips_resultAddDate;
      // case ShowCaseStates.resultAssignedDragAndDrop:
      //   return S.current.tips_resultAssignedDragAndDrop;
      case ShowCaseStates.resultAddOrRemove:
        return S.current.tips_resultAddOrRemove;
      case ShowCaseStates.resultButtonsOffice:
        return S.current.tips_resultButtonsOffice;

      // case ShowCaseStates.resultButtonsOfficeExplain:
      //   return S.current.tips_resultButtonsOffice;

      case ShowCaseStates.resultButtonThirdParty:
        return S.current.tips_resultButtonThirdParty;

      // case ShowCaseStates.resultButtonThirdPartyExplain:
      //   return S.current.tips_resultButtonThirdParty;


      case ShowCaseStates.resultButtonRateUs:
        return S.current.tips_resultButtonRateUs;
      // case ShowCaseStates.resultButtonRateUsExplain:
      //   return S.current.tips_resultButtonRateUsExplain;
      case ShowCaseStates.resultButtonFinish:
        return S.current.tips_resultButtonFinish;
      case ShowCaseStates.allMeets:
        return S.current.tips_allMeets;
      case ShowCaseStates.goReview:
        return S.current.tips_goReview;

    }
  }
}
