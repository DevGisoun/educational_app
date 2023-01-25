import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/configs/themes/settings_icons.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:educational_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  /// Settings Tab List
  final List<Map<String, dynamic>> settingsList = [
    {
      'name': 'Profile',
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

  /// 현재 선택된 Tab Index
  RxInt selectedTabIndex = 0.obs;

  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    // getUser();
    super.onReady();
  }

  Future<void> getUser() async {
    try {
      if (user.value == null) {
        return;
      }

      QuerySnapshot<Map<String, dynamic>> data =
          await userRef.where('email', isEqualTo: user.value!.email).get();
      // UserModel.fromJson(json)
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
