import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/custom_text_styles.dart';
import 'package:educational_app/src/configs/themes/settings_icons.dart';
import 'package:educational_app/src/controllers/settings/settings_controller.dart';
import 'package:educational_app/src/controllers/settings/settings_url_controller.dart';
import 'package:educational_app/src/widgets/common/main_button.dart';
import 'package:educational_app/src/widgets/settings/settings_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/app_layout.dart';

class SettingsURL extends GetView<SettingsURLController> {
  final SettingsController settingsController;

  SettingsURL({
    super.key,
    required this.settingsController,
  });

  TextEditingController textEditingController_github = TextEditingController();
  TextEditingController textEditingController_website = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => settingsController.unFocusKeyboard(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const SettingsAppBar(
          title: 'URL',
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: AppLayout.getHeight(10),
          ),
          child: Obx(
            () {
              if (controller.user != null) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: AppLayout.getWidth(30),
                  ),
                  child: Column(
                    children: [
                      _urlTextField(
                        icon: SettingsIcons.github_circled,
                        title: 'Github',
                        controller: textEditingController_github,
                        initText: controller.githubURL,
                      ),
                      Gap(
                        AppLayout.getHeight(30),
                      ),
                      _urlTextField(
                        icon: SettingsIcons.web_asset,
                        title: 'Website',
                        controller: textEditingController_website,
                        initText: controller.websiteURL,
                      ),
                      Gap(
                        AppLayout.getHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.setURL(
                                github: textEditingController_github.text,
                                website: textEditingController_website.text,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                AppLayout.getHeight(10),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: onSurfaceTextColor,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Check',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: InkWell(
                    onTap: () {
                      controller.navigateToLoginPage();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.getWidth(50),
                        vertical: AppLayout.getHeight(10),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: onSurfaceTextColor,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        controller.pageMessage.toString(),
                        style: cardTitles(Get.context),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _urlTextField({
  IconData? icon,
  required String title,
  required TextEditingController controller,
  required RxString initText,
}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            icon,
            size: AppLayout.getWidth(30),
          ),
          Gap(
            AppLayout.getWidth(10),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: AppLayout.getHeight(20),
            ),
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          controller: controller..text = initText.value,
          decoration: const InputDecoration(
            hintText: '(optional)',
          ),
        ),
      ),
    ],
  );
}
