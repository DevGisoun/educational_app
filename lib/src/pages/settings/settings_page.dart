import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/controllers/settings/settings_controller.dart';
import 'package:educational_app/src/pages/settings/settings_profile.dart';
import 'package:educational_app/src/pages/settings/settings_url.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    const double tabHeight = 50;
    const int tabDuration = 100; // ms

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: AppLayout.getWidth(100),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectTab(index);
                        controller.unFocusKeyboard();
                        pageController.jumpToPage(index);
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(
                                milliseconds: tabDuration,
                              ),
                              width: 5,
                              height: controller.selectedTabIndex.value == index
                                  ? tabHeight
                                  : 0,
                              color: customScaffoldColor(Get.context!),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: tabDuration,
                                ),
                                alignment: Alignment.center,
                                height: tabHeight,
                                color:
                                    controller.selectedTabIndex.value == index
                                        ? Colors.blueGrey.withOpacity(0.2)
                                        : Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppLayout.getWidth(5),
                                    vertical: AppLayout.getHeight(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        controller.settingsList[index]['icon'],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: AppLayout.getWidth(5),
                                        ),
                                        child: Text(
                                          controller.settingsList[index]
                                              ['name'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: AppLayout.getHeight(5),
                    );
                  },
                  itemCount: controller.settingsList.length,
                ),
              ),
              Gap(
                AppLayout.getWidth(30),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Account
                    Center(
                      child: SettingsProfile(
                        settingsController: controller,
                      ),
                    ),
                    // URL
                    Center(
                      child: SettingsURL(
                        settingsController: controller,
                      ),
                    ),
                    // Tab2
                    Center(
                      child: Text(controller.settingsList[2]['name']),
                    ),
                    // Tab3
                    Center(
                      child: Text(controller.settingsList[3]['name']),
                    ),
                    // Tab4
                    Center(
                      child: Text(controller.settingsList[4]['name']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
