import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../auth_controller.dart';

class SettingsURLController extends GetxController {
  RxString githubURL = ''.obs;
  RxString websiteURL = ''.obs;
  RxString pageMessage = ''.obs;

  User? user = Get.find<AuthController>().getUser();

  @override
  void onReady() {
    initURL();

    super.onReady();
  }

  Future<void> initURL() async {
    if (user == null) {
      pageMessage.value = '로그인';
      return;
    } else {
      pageMessage.value = '';
    }

    try {
      await userRef.doc(user!.email).get().then((userModel) {
        githubURL.value = userModel['github'];
        websiteURL.value = userModel['website'];
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> setURL({
    required String github,
    required String website,
  }) async {
    if (user == null) return;

    return await userRef.doc(user!.email).update({
      'github': github,
      'website': website,
    });
  }

  void navigateToLoginPage() {
    AuthController _authController = Get.find();
    Get.back();
    _authController.navigateToLoginPage();
  }
}
