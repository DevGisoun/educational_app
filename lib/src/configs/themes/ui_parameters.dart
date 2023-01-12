import 'package:flutter/material.dart';

/// 기기의 다크 모드 여부 체크
class UIParameters {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
