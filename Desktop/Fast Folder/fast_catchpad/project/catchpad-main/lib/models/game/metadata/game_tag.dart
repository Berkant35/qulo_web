import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

enum GameTag {
  focus, // Odak
  resistance, // Dayanıklılık
  memory, // Hafıza
  emotional, // Duygusal
  visual, // Görsel
  condition, // Kondisyon
  intelligence, // Zeka
  agility, // Çeviklik
  teamWork, // Takım Çalışması
  reflex, // Refleks
  numeral, // Sayısal
  auditory, // İşitsel
  grossMotor, // Kaba Motor
  drama, // Drama
  balance, // Denge
  strength, // Kuvvet
  exercise, // Egzersiz
  speed, // Hız
  music, // Müzik
  knowledge,
  quickness,

  //
  ;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case focus:
        return inst.game_tag_focus;
      case resistance:
        return inst.game_tag_resistance;
      case memory:
        return inst.game_tag_memory;
      case emotional:
        return inst.game_tag_emotional;
      case visual:
        return inst.game_tag_visual;
      case condition:
        return inst.game_tag_condition;
      case intelligence:
        return inst.game_tag_intelligence;
      case agility:
        return inst.game_tag_agility;
      case teamWork:
        return inst.game_tag_teamWork;
      case reflex:
        return inst.game_tag_reflex;
      case numeral:
        return inst.game_tag_numeral;
      case auditory:
        return inst.game_tag_auditory;
      case grossMotor:
        return inst.game_tag_grossMotor;
      case drama:
        return inst.game_tag_drama;
      case balance:
        return inst.game_tag_balance;
      case strength:
        return inst.game_tag_strength;
      case exercise:
        return inst.game_tag_exercise;
      case speed:
        return inst.game_earning_speed;
      case music:
        return inst.game_ui_music;
      case knowledge:
        return inst.game_ui_knowledge;
      case quickness:
        return inst.game_tag_quickness;
    }
  }
}
