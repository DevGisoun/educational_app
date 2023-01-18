import 'package:educational_app/firebase_options.dart';
import 'package:educational_app/src/bindings/initial_bindings.dart';
import 'package:educational_app/src/configs/themes/app_light_theme.dart';
import 'package:educational_app/src/controllers/theme_controller.dart';
import 'package:educational_app/src/pages/data_uploader_screen.dart';
import 'package:educational_app/src/pages/introduction/introduction_screen.dart';
import 'package:educational_app/src/pages/splash/splash_screen.dart';
import 'package:educational_app/src/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// /// Firebase Back-End에 json 데이터 업로드
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     GetMaterialApp(
//       home: DataUploaderScreen(),
//     ),
//   );
// }

void main(List<String> args) async {
  // 다음에 호출되는 함수의 모든 실행이 끝날 때까지 대기
  // (ex. 서버 연결, 메모리 초기화, 비동기 동작 등)
  WidgetsFlutterBinding.ensureInitialized();

  // 초기 App 종속성 호출
  InitialBindings().dependencies();

  // Firebase App 인스턴스 초기화
  await Firebase.initializeApp(
    // 기기 플랫폼에 따른 초기화 옵션
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EducationalApp());
}

/// App 실행 시 가장 먼저 실행
class EducationalApp extends GetView<ThemeController> {
  const EducationalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: controller.lightTheme,
      darkTheme: controller.darkTheme,
      getPages: AppRoutes.routes(),
    );
  }
}
