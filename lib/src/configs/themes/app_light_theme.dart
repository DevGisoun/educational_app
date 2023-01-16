/// 밝은 테마에서의 Gradient 색상 전역 변수 지정

import 'package:educational_app/src/configs/themes/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

/// 상단 색상 (밝은 테마)
const Color primaryLightColor_1 = Color(0xff3ac3cb);

/// 하단 색상 (밝은 테마)
const Color primaryLightColor_2 = Color(0xfff85187);

/// 기본 Text 색상 (밝은 테마)
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);

/// Card 색상 (밝은 테마)
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

/// Icon, Text 테마 적용 (밝은 테마)
class LightTheme with SubThemeDataMixin {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      primaryColor: primaryLightColor_2,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      textTheme: getTextThemes().apply(
        bodyColor: mainTextColorLight,
        displayColor: mainTextColorLight,
      ),
    );
  }
}
