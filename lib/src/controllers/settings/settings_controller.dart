import 'package:educational_app/src/configs/themes/settings_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  /// 현재 선택된 Tab Index
  RxInt selectedTabIndex = 0.obs;

  /// Settings Tab List
  final List<Map<String, dynamic>> settingsList = [
    {
      'name': 'Account',
      'icon': SettingsIcons.account_circle,
    },
    {
      'name': 'URL',
      'icon': SettingsIcons.link,
    },
    {
      'name': 'Tab2',
      'icon': SettingsIcons.dot_3,
    },
    {
      'name': 'Tab3',
      'icon': SettingsIcons.dot_3,
    },
    {
      'name': 'Tab4',
      'icon': SettingsIcons.dot_3,
    },
  ];

  @override
  void onReady() {
    super.onReady();
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
