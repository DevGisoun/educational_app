import 'package:educational_app/src/controllers/auth_controller.dart';
import 'package:educational_app/src/controllers/theme_controller.dart';
import 'package:get/get.dart';

import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    // permanent : GetxController를 매모리에 영구적으로 저장
    Get.put(AuthController(), permanent: true);
    // Get.put(FirebaseStorageService());
    Get.lazyPut(() => FirebaseStorageService());
  }
}
