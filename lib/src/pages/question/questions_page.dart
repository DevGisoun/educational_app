import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:educational_app/src/controllers/question_papers/questions_controller.dart';
import 'package:educational_app/src/firebase_ref/loading_status.dart';
import 'package:educational_app/src/pages/question/test_overview_page.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:educational_app/src/widgets/common/background_decoration.dart';
import 'package:educational_app/src/widgets/common/custom_app_bar.dart';
import 'package:educational_app/src/widgets/common/main_button.dart';
import 'package:educational_app/src/widgets/common/question_place_holder.dart';
import 'package:educational_app/src/widgets/content_area.dart';
import 'package:educational_app/src/widgets/questions/answer_card.dart';
import 'package:educational_app/src/widgets/questions/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuestionsPage extends GetView<QuestionsController> {
  const QuestionsPage({super.key});

  static const String routeName = '/questionsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(8),
            vertical: AppLayout.getHeight(4),
          ),
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: onSurfaceTextColor,
                width: AppLayout.getWidth(2),
              ),
            ),
          ),
          child: Obx(
            () => CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            ),
          ),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTS,
          ),
        ),
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                  child: ContentArea(
                    child: QuestionPlaceHolder(),
                  ),
                ),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: AppLayout.getHeight(50),
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestion.value!.question,
                            style: questionTS,
                          ),
                          GetBuilder<QuestionsController>(
                            id: 'answer_list',
                            builder: (context) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  top: AppLayout.getHeight(25),
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers[index];
                                  return AnswerCard(
                                    answer:
                                        '${answer.identifier}. ${answer.answer}',
                                    onTap: () {
                                      return controller
                                          .selectedAnswer(answer.identifier);
                                    },
                                    isSelected: answer.identifier ==
                                        controller.currentQuestion.value!
                                            .selectedAnswer,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Gap(
                                    AppLayout.getHeight(10),
                                  );
                                },
                                itemCount: controller
                                    .currentQuestion.value!.answers.length,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: SizedBox(
                          width: AppLayout.getWidth(55),
                          height: AppLayout.getHeight(55),
                          child: MainButton(
                            onTap: () {
                              controller.prevQuestion();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: MainButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(TestOverviewPage.routeName)
                                  : controller.nextQuestion();
                            },
                            title:
                                controller.isLastQuestion ? 'Complete' : 'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
