import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;

  const ContentArea({
    super.key,
    this.addPadding = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding,
              )
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
