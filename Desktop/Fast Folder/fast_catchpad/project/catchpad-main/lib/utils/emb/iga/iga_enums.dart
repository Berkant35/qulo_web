import 'package:flutter/material.dart';

enum IGAStates {
  home,
  onBoardingOne,
  onBoardingTwo,
  onBoardingThree,
  onBoardingFour,
  result,
  lastRegister,
  seeLeaderboard

}

enum IGAPlayerModes { singlePlayer, multiPlayer }

enum IGALevelModes { easy, hard }

enum IgaAssets {
  landing_background,
  background,
  share,
  iga_in_game_background,
  qr_get_discount,
  graph,
  line_chart,
  iga_in_game_thunderbolt,
  union,
  iga_left_hand,
  iga_right_hand,
  people,
  pad_stage_4,
  pad_stage_3,
  pad_stage_2,
  pad_stage_1,
  contact,
  rank_plate,
  pad_many,
  pad_less,
  iga_result_game_thunderbolt,
  pad_tap,
  single_player,
  multiplayer,
  pad_group_less,
  tac,
  pad,
  lightning,
  high_five,
  f1,
  vs,
  formula_race,
  bul_bakalim,
  bul_bakalim_left,
  bul_bakalim_right,
  attention,
  tile_blue_active,
  qr_chatbot,
  tile_blue,
  tile_green_active,
  tile_green,
  tile_red_active,
  tile_red,
  tile_yellow_active,
  tile_yellow,
  listen_and_catch,
  pad_match,
  team_work,
  siralama,
  iga_kickstarter,
  first,
  qr_kickstarter,
  cp_logo_text,
  pad_group_more,
  ic_wake_up;

  String get getPath => 'assets/iga/$name.png';
  String get getPathWithoutIga => 'assets/app_icon/$name.png';
  Image get getIcon => Image.asset(
        getPath,
        height: 25,
        width: 25,
      );

      Image  getCustomIconWithSize(double size) => Image.asset(
        getPath,
        height: size,
      );
}

