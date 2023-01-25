import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/controllers/auth_controller.dart';
import 'package:educational_app/src/models/user_model.dart';
import 'package:educational_app/src/pages/settings/settings_page.dart';
import 'package:educational_app/src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase_ref/loading_status.dart';
import '../firebase_ref/references.dart';

class AppZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  final loadingStatus = LoadingStatus.loading.obs;

  Rxn<User?> user = Rxn();
  RxBool checkLogin = RxBool(false);
  Rx<UserModel> userModel = UserModel().obs;

  @override
  Future<void> onReady() async {
    user.value = Get.find<AuthController>().getUser();
    if (user.value != null) {
      await getUserData(user.value!.email!);
    }

    super.onReady();
  }

  Future<UserModel?> getUserData(String email) async {
    loadingStatus.value = LoadingStatus.loading;

    QuerySnapshot<Map<String, dynamic>> myRecentTests =
        await userMyRecentTestsRef(email: email).get();
    List<Map<String, dynamic>> myRecentTestsList =
        myRecentTests.docs.map((paper) => paper.data()).toList();

    var userData =
        await UserRepository.loginCheckByEmail(email, myRecentTestsList);

    if (userData != null) {
      userModel.value = userData;
    }

    loadingStatus.value = LoadingStatus.completed;
    return userData;
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
        if (user['website'] == null || user['website'] == '') {
          return;
        }
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
