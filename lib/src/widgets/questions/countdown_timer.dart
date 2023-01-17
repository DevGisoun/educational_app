import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CountdownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountdownTimer({
    super.key,
    this.color,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        Gap(
          AppLayout.getWidth(5),
        ),
        Text(
          time,
          style: countDownTimerTS().copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
