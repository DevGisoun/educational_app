import 'package:educational_app/src/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void website() {
    // _launch('https://github.com/DevGisoun');
    print(user.value!.email);
  }

  void facebook() {
    _launch('https://facebook.com');
  }

  /// 이메일 클라이언트 열기
  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: user.value == null ? '' : user.value!.email,
    );

    _launch(emailLaunchUri.toString());
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
