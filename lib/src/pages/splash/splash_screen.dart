import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: mainGradient(context),
        ),
        child: Center(
          child: SizedBox(
            width: AppLayout.getWidth(200),
            height: AppLayout.getHeight(200),
            child: Image.asset('assets/images/app_splash_logo.png'),
          ),
        ),
      ),
    );
  }
}
