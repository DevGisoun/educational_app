import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

import '../../utils/app_layout.dart';

TextStyle cardTitles(context) => TextStyle(
      color: UIParameters.isDarkMode()
          ? Theme.of(context).textTheme.bodyText1!.color
          : Theme.of(context).primaryColor,
      fontSize: AppLayout.getHeight(18),
      fontWeight: FontWeight.bold,
    );

const detailText = TextStyle(
  fontSize: 12,
);
const headerText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: onSurfaceTextColor,
);
