import 'package:catchpad/utils/custom_svg.dart';

class CatchpadIconsV2 {
  static const String _basePath = 'assets/icons/iconsV2/';
  static const String _basePathV2 = 'assets/v2/icons/';

  static final CustomSvg alternativeEdit =
      _getCustomSvg('ic_alternative_edit.svg');
  static final CustomSvg android = _getCustomSvg('ic_android.svg');
  static final CustomSvg apple = _getCustomSvg('ic_apple.svg');
  static final CustomSvg catchType = _getCustomSvg('ic_catch_type.svg');
  static final CustomSvg closeAccount = _getCustomSvg('ic_close_account.svg');
  static final CustomSvg contact = _getCustomSvg('ic_contact.svg');
  static final CustomSvg contentDistance =
      _getCustomSvg('ic_content_distance.svg');
  static final CustomSvg contentTap = _getCustomSvg('ic_content_tap.svg');
  static final CustomSvg create = _getCustomSvg('ic_create.svg');
  static final CustomSvg createOwn = _getCustomSvg('ic_create_own.svg');
  static final CustomSvg cycles = _getCustomSvg('ic_cycles.svg');
  static final CustomSvg degree = _getCustomSvg('ic_degree.svg');
  static final CustomSvg delay = _getCustomSvg('ic_delay.svg');
  static final CustomSvg distance = _getCustomSvg('ic_distance.svg');
  static final CustomSvg drop = _getCustomSvg('ic_drop.svg');
  static final CustomSvg edit = _getCustomSvg('ic_edit.svg');
  static final CustomSvg effect = _getCustomSvg('ic_effect.svg');
  static final CustomSvg exit = _getCustomSvg('ic_exit.svg');
  static final CustomSvg game = _getCustomSvg('ic_game.svg');
  static final CustomSvg history = _getCustomSvg('ic_history.svg');
  static final CustomSvg home = _getCustomSvg('ic_home.svg');
  static final CustomSvg language = _getCustomSvg('ic_language.svg');
  static final CustomSvg level = _getCustomSvg('ic_level.svg');
  static final CustomSvg myGroups = _getCustomSvg('ic_my_groups.svg');
  static final CustomSvg performanceAnalyz =
      _getCustomSvg('ic_performance_analyz.svg');
  static final CustomSvg preference = _getCustomSvg('ic_preference.svg');
  static final CustomSvg question = _getCustomSvg('ic_question.svg');
  static final CustomSvg questionMark = _getCustomSvg('ic_question_mark.svg');
  static final CustomSvg save = _getCustomSvg('ic_save.svg');
  static final CustomSvg sensivity = _getCustomSvg('ic_sensivity.svg');
  static final CustomSvg settings = _getCustomSvg('ic_settings.svg');
  static final CustomSvg soundLight = _getCustomSvg('ic_sound_light.svg');
  static final CustomSvg soundPad = _getCustomSvg('ic_sound_pad.svg');
  static final CustomSvg statics = _getCustomSvg('ic_statics.svg');
  static final CustomSvg test = _getCustomSvg('ic_test.svg');
  static final CustomSvg time = _getCustomSvg('ic_time.svg');
  static final CustomSvg timeout = _getCustomSvg('ic_timeout.svg');
  static final CustomSvg vector = _getCustomSvg('ic_vector.svg');
  static final CustomSvg vector1 = _getCustomSvg('ic_vector_1.svg');
  static final CustomSvg vector2 = _getCustomSvg('ic_vector_2.svg');
  static final CustomSvg vector3 = _getCustomSvg('ic_vector_3.svg');
  static final CustomSvg vibration = _getCustomSvg('ic_vibration.svg');
  static final CustomSvg pad = _getCustomSvg('ic_pad.svg');
  static final CustomSvg excel = _getCustomSvg('ic_excel.svg');

  static final CustomSvg catchpost = _getCustomSvgV2('ic_catchpost.svg');
  static final CustomSvg homeV2 = _getCustomSvgV2('ic_home.svg');
  static final CustomSvg settingsV2 = _getCustomSvgV2('ic_settings.svg');
  static final CustomSvg stats = _getCustomSvgV2('ic_stats.svg');
  static final CustomSvg testV2 = _getCustomSvgV2('ic_test.svg');
  static final CustomSvg filter = _getCustomSvgV2('filter.svg');
  static final CustomSvg backArrow = _getCustomSvgV2('back_arrow.svg');
  static final CustomSvg radioActive = _getCustomSvgV2('radial.svg');
  static final CustomSvg radioDeActive = _getCustomSvgV2('radial-2.svg');
  static final CustomSvg comment = _getCustomSvgV2('comment.svg');
  static final CustomSvg rateIcon = _getCustomSvgV2('rate_icon.svg');
  static final CustomSvg share = _getCustomSvgV2('share.svg');
  static final CustomSvg favorites = _getCustomSvgV2('favorites.svg');
  static final CustomSvg people = _getCustomSvgV2('people.svg');

  static CustomSvg _getCustomSvg(String iconName) {
    return CustomSvg(imagepath: _basePath + iconName);
  }

  static CustomSvg _getCustomSvgV2(String iconName) {
    return CustomSvg(imagepath: _basePathV2 + iconName);
  }
}
