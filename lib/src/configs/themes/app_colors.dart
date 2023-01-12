/// 기기의 테마에 따른 App 색상 설정

import 'package:educational_app/src/configs/themes/app_light_theme.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

import 'app_dark_theme.dart';

/// 밝은 테마 Gradient 설정
const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryLightColor_1,
    primaryLightColor_2,
  ],
);

/// 다크 테마 Gradient 설정
const mainGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryDarkColor_1,
    primaryDarkColor_2,
  ],
);

/// 다크 테마 여부 체크 후 Gradient 색상 반환
LinearGradient mainGradient(BuildContext context) {
  return UIParameters.isDarkMode(context)
      ? mainGradientDark
      : mainGradientLight;
}

/// White Color
const Color onSurfaceTextColor = Colors.white;
