import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppIconText extends StatelessWidget {
  final Icon icon;
  final Widget text;

  const AppIconText({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Gap(
          AppLayout.getWidth(4),
        ),
        text,
      ],
    );
  }
}
