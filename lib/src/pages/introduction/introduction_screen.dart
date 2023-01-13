import 'package:educational_app/src/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../utils/app_layout.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: mainGradient(context),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: AppLayout.getHeight(65),
                ),
                Gap(
                  AppLayout.getHeight(40),
                ),
                Text(
                  'This is a study app. You can use it as you want.' +
                      'if you understand how this works,' +
                      'you would be able to scale it.',
                  style: TextStyle(
                    fontSize: AppLayout.getHeight(18),
                    color: onSurfaceTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(
                  AppLayout.getHeight(40),
                ),
                AppCircleButton(
                  onTap: () {
                    Get.offAndToNamed('/home');
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: AppLayout.getHeight(35),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
