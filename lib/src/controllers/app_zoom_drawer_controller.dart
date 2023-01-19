import 'package:educational_app/src/controllers/auth_controller.dart';
import 'package:educational_app/src/pages/settings/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase_ref/references.dart';

class AppZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  Rxn<User?> user = Rxn();
  RxBool checkLogin = RxBool(false);

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();

    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle!.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLoginPage();
  }

  void website() async {
    try {
      await userRef.doc(user.value!.email).get().then((user) {
        _launch(user['website']);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void github() async {
    try {
      await userRef.doc(user.value!.email).get().then((user) {
        _launch('https://github.com/${user['github']}');
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// 이메일 클라이언트 열기
  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: user.value == null ? '' : user.value!.email,
    );

    _launch(emailLaunchUri.toString());
  }

  /// URLSettingPage 이동
  void settings() {
    Get.toNamed(SettingsPage.routeName);
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }

  bool checkLogIn() {
    if (user.value == null) {
      return checkLogin(false);
    } else {
      return checkLogin(true);
    }
  }
}
