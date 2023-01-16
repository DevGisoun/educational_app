import 'package:educational_app/src/controllers/app_zoom_drawer_controller.dart';
import 'package:educational_app/src/pages/home/home_screen.dart';
import 'package:educational_app/src/pages/introduction/introduction_screen.dart';
import 'package:educational_app/src/pages/login/login_screen.dart';
import 'package:get/get.dart';

import '../controllers/question_papers/question_paper_controller.dart';
import '../pages/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/introduction',
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(QuestionPaperController());
              Get.put(AppZoomDrawerController());
            },
          ),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
      ];
}
