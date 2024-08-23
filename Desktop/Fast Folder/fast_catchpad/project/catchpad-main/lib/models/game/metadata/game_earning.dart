import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

enum GameEarning {
  focus, // Odak
  resistance, // Dayanıklılık
  decision_making, // Karar verme
  reaction_speed, // Reaksiyon Hızı
  neural_priming, // Nöral Uyarılma
  peripheral_vision, // Çevre Görüşü
  competitive_spirit, // Rekabet Duygusu
  auditory_reaction, // İşitsel Reaksiyon
  visual_memory, // Görsel Hafıza
  team_spirit, // Takım Ruhu
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
  auditoryIntelligence, // İşitsel Zeka
  grossMotor, // Kaba Motor
  drama, // Drama
  balance, // Denge
  sync, // Senkrozisyon
  coordination, //Koordinasyon
  muscleDev, // Kas Hafızası
  speed, // Hız
  competition, // Rekabet
  strength, // Kuvvet
  exercise, // Egzersiz
  music, // Müzik
  knowledge // Bilgi
  ; // Kas Gelişimi

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case focus:
        return inst.game_earning_focus;
      case resistance:
        return inst.game_earning_resistance;
      case decision_making:
        return inst.game_earning_decision_making;
      case reaction_speed:
        return inst.game_earning_reaction_speed;
      case neural_priming:
        return inst.game_earning_neural_priming;
      case peripheral_vision:
        return inst.game_earning_peripheral_vision;
      case competitive_spirit:
        return inst.game_earning_competitive_spirit;
      case auditory_reaction:
        return inst.game_earning_auditory_reaction;
      case visual_memory:
        return inst.game_earning_visual_memory;
      case team_spirit:
        return inst.game_earning_team_spirit;
      case memory:
        return inst.game_earning_memory;
      case emotional:
        return inst.game_earning_emotional;
      case visual:
        return inst.game_earning_visual;
      case condition:
        return inst.game_earning_condition;
      case intelligence:
        return inst.game_earning_intelligence;
      case agility:
        return inst.game_earning_agility;
      case teamWork:
        return inst.game_earning_teamWork;
      case reflex:
        return inst.game_earning_reflex;
      case numeral:
        return inst.game_earning_numeral;
      case auditory:
        return inst.game_earning_auditory;
      case auditoryIntelligence:
        return inst.game_earning_auditory_intelligence;
      case grossMotor:
        return inst.game_earning_grossMotor;
      case drama:
        return inst.game_earning_drama;
      case balance:
        return inst.game_earning_balance;
      case sync:
        return inst.game_earning_sync;
      case coordination:
        return inst.game_earning_coordination;
      case muscleDev:
        return inst.game_earning_muscleDev;
      case speed:
        return inst.game_earning_speed;
      case strength:
        return inst.game_earning_strength;
      case exercise:
        return inst.game_earning_exercise;
      case competition:
        return inst.game_earning_exercise;
      case music:
        return inst.game_ui_music;
      case knowledge:
        return inst.game_ui_knowledge;
    }
  }
}
