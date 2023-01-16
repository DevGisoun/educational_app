import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _mobileScreenPadding = 25.0;
const double _cardBorderRadius = 10.0;

double get mobileScreenPadding => _mobileScreenPadding;
double get cardBorderRadius => _cardBorderRadius;

/// 기기 또는 기기 설정에 대한 UI 관련 Class
class UIParameters {
  static EdgeInsets get mobileScreenPadding =>
      const EdgeInsets.all(_mobileScreenPadding);
  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(_cardBorderRadius);

  /// 기기의 다크 모드 여부 체크
  static bool isDarkMode() {
    return Get.isDarkMode ? true : false;
  }
}
