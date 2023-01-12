import 'package:educational_app/src/pages/introduction/introduction_screen.dart';
import 'package:get/get.dart';

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
      ];
}
