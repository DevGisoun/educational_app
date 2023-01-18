import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/app_icons.dart';
import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:educational_app/src/controllers/app_zoom_drawer_controller.dart';
import 'package:educational_app/src/controllers/question_papers/question_paper_controller.dart';
import 'package:educational_app/src/pages/home/app_menu_screen.dart';
import 'package:educational_app/src/pages/home/question_card.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:educational_app/src/widgets/app_circle_button.dart';
import 'package:educational_app/src/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<AppZoomDrawerController> {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();

    return Scaffold(
      body: GetBuilder<AppZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            controller: _.zoomDrawerController,
            borderRadius: 50.0,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.DefaultStyle,
            backgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: MediaQuery.of(context).size.width * 0.4,
            menuScreen: const AppMenuScreen(),
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCircleButton(
                            onTap: controller.toggleDrawer,
                            child: const Icon(AppIcons.menuLeft),
                          ),
                          Gap(
                            AppLayout.getHeight(10),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppLayout.getHeight(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Obx(
                                  () {
                                    var displayName = controller.user.value ==
                                            null
                                        ? 'Friend'
                                        : controller.user.value!.displayName;
                                    return Text(
                                      'Hello, $displayName !',
                                      style: detailText.copyWith(
                                        color: onSurfaceTextColor,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'What do you want to learn today ?',
                            style: headerText.copyWith(
                              fontSize: AppLayout.getHeight(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(8),
                        ),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return QuestionCard(
                                  model:
                                      questionPaperController.allPapers[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Gap(
                                  AppLayout.getHeight(20),
                                );
                              },
                              itemCount:
                                  questionPaperController.allPapers.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
