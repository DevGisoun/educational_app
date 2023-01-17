import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:educational_app/src/controllers/question_papers/questions_controller.dart';
import 'package:educational_app/src/controllers/question_papers/questions_controller_extension.dart';
import 'package:educational_app/src/pages/question/answer_check_page.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:educational_app/src/widgets/common/background_decoration.dart';
import 'package:educational_app/src/widgets/common/custom_app_bar.dart';
import 'package:educational_app/src/widgets/common/main_button.dart';
import 'package:educational_app/src/widgets/content_area.dart';
import 'package:educational_app/src/widgets/questions/answer_card.dart';
import 'package:educational_app/src/widgets/questions/question_number_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResultPage extends GetView<QuestionsController> {
  const ResultPage({super.key});

  static const String routeName = '/resultPage';

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: SizedBox(
          height: AppLayout.getHeight(80),
        ),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 5,
                      ),
                      child: Text(
                        'Congratulations',
                        style: headerText.copyWith(
                          color: _textColor,
                        ),
                      ),
                    ),
                    Text(
                      'You have ${controller.points} points',
                      style: TextStyle(
                        color: _textColor,
                      ),
                    ),
                    Gap(
                      AppLayout.getHeight(25),
                    ),
                    const Text(
                      'Tap below question numbers to view correct answers',
                      textAlign: TextAlign.center,
                    ),
                    Gap(
                      AppLayout.getHeight(25),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: controller.allQuestions.length,
                        itemBuilder: (_, index) {
                          final _question = controller.allQuestions[index];
                          AnswerStatus _status = AnswerStatus.notAnswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;

                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_question.selectedAnswer == null) {
                            _status = AnswerStatus.wrong;
                          } else {
                            _status = AnswerStatus.wrong;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _status,
                            onTap: () {
                              controller.jumpToQuestion(
                                index,
                                isGoBack: false,
                              );
                              Get.toNamed(AnswerCheckPage.routeName);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: Colors.blueGrey,
                        title: 'Try Again',
                      ),
                    ),
                    Gap(
                      AppLayout.getWidth(5),
                    ),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.saveTestResult();
                        },
                        color: Colors.blueGrey.shade300,
                        title: 'Go Home',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
