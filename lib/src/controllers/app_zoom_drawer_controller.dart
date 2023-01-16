import 'package:educational_app/src/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();

    super.onReady();
  }

  void toggleDrawer() {
    print('toggle');
    zoomDrawerController.toggle!.call();
    // zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void website() {
    _launch('https://github.com/DevGisoun');
  }

  void facebook() {
    _launch('https://facebook.com');
  }

  /// 이메일 클라이언트 열기
  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'devgisoun@gmail.com',
    );

    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }
}
