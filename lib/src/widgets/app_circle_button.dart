import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  const AppCircleButton({
    super.key,
    required this.child,
    this.color,
    this.width = 60,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material 투명 속성
      type: MaterialType.transparency,
      // 안티앨리어싱 적용 X
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
