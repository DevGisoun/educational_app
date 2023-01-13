import 'package:educational_app/src/controllers/question_papers/question_paper_controller.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();

    return Scaffold(
      body: Obx(
        () => ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              child: SizedBox(
                width: AppLayout.getWidth(200),
                height: AppLayout.getHeight(200),
                child: FadeInImage(
                  image: NetworkImage(
                    _questionPaperController.allPaperImages[index],
                  ),
                  placeholder: const AssetImage(
                    'assets/images/app_splash_logo.png',
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Gap(
              AppLayout.getHeight(20),
            );
          },
          itemCount: _questionPaperController.allPaperImages.length,
        ),
      ),
    );
  }
}
