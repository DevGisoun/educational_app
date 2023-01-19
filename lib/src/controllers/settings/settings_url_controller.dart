import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../auth_controller.dart';

class SettingsURLController extends GetxController {
  RxString githubURL = ''.obs;
  RxString websiteURL = ''.obs;

  User? _user = Get.find<AuthController>().getUser();

  @override
  void onReady() {
    initURL();

    super.onReady();
  }

  Future<void> initURL() async {
    if (_user == null) return;

    try {
      await userRef.doc(_user!.email).get().then((user) {
        githubURL.value = user['github'];
        websiteURL.value = user['website'];
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
    if (_user == null) return;

    return await userRef.doc(_user!.email).update({
      'github': github,
      'website': website,
    });
  }
}
