import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/controllers/question_papers/questions_controller.dart';
import 'package:educational_app/src/pages/question/result_page.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:educational_app/src/widgets/common/background_decoration.dart';
import 'package:educational_app/src/widgets/common/custom_app_bar.dart';
import 'package:educational_app/src/widgets/content_area.dart';
import 'package:educational_app/src/widgets/questions/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerCheckPage extends GetView<QuestionsController> {
  const AnswerCheckPage({super.key});

  static const String routeName = '/answerCheckScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultPage.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                        ),
                        GetBuilder<QuestionsController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers[index];
                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;
                                final String answerText =
                                    '${answer.identifier}. ${answer.answer}';

                                if (correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  // Correct Answer
                                  return CorrectAnswer(
                                    answer: answerText,
                                  );
                                } else if (selectedAnswer == null) {
                                  // Not Selected Answer
                                  return NotAnswered(
                                    answer: answerText,
                                  );
                                } else if (correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  // Wrong Answer
                                  return WrongAnswer(
                                    answer: answerText,
                                  );
                                } else if (correctAnswer == answer.identifier) {
                                  // Correct Answer
                                  return CorrectAnswer(
                                    answer: answerText,
                                  );
                                }

                                return AnswerCard(
                                  answer: answerText,
                                  onTap: () {},
                                  isSelected: false,
                                );
                              },
                              separatorBuilder: (_, index) {
                                return SizedBox(
                                  height: AppLayout.getHeight(10),
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
            ],
          ),
        ),
      ),
    );
  }
}
