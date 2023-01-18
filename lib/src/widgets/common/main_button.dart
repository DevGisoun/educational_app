import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/ui_parameters.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool enabled;
  final Widget? child;
  final Color? color;

  const MainButton({
    super.key,
    this.title = '',
    required this.onTap,
    this.enabled = true,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: AppLayout.getHeight(55),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            AppLayout.getHeight(13),
          ),
          onTap: enabled == false ? null : onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppLayout.getHeight(15),
              ),
              color: color ?? Theme.of(context).cardColor,
            ),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? onSurfaceTextColor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
