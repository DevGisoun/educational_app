import 'package:educational_app/src/configs/themes/app_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/themes/app_light_theme.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  @override
  void onInit() {
    initializeThemeData();

    super.onInit();
  }

  /// App 테마 데이터 초기화
  initializeThemeData() {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  // Read-Only Getters
  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}
