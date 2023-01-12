/// 다크 테마에서의 Gradient 색상 전역 변수 지정

import 'package:educational_app/src/configs/themes/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

/// 상단 색상 (다크 테마)
const Color primaryDarkColor_1 = Color(0xff2e3c62);

/// 하단 색상 (다크 테마)
const Color primaryDarkColor_2 = Color(0xff99ace1);

/// 기본 Text 색상 (다크 테마)
const Color mainTextColorDark = Colors.white;

/// Icon, Text 테마 적용 (다크 테마)
class DarkTheme with SubThemeDataMixin {
  buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextThemes().apply(
        bodyColor: mainTextColorDark,
        displayColor: mainTextColorDark,
      ),
    );
  }
}
