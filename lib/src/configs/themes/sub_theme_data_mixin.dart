import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

mixin SubThemeDataMixin {
  /// Text 테마 반환
  ///
  /// (Google Font)
  TextTheme getTextThemes() {
    return GoogleFonts.quicksandTextTheme(
      const TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  /// Icon 테마 반환
  IconThemeData getIconTheme() {
    return IconThemeData(
      color: onSurfaceTextColor,
      size: AppLayout.getHeight(16),
    );
  }
}
