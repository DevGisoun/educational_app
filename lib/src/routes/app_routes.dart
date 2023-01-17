import 'package:educational_app/src/controllers/app_zoom_drawer_controller.dart';
import 'package:educational_app/src/controllers/question_papers/questions_controller.dart';
import 'package:educational_app/src/pages/home/home_screen.dart';
import 'package:educational_app/src/pages/introduction/introduction_screen.dart';
import 'package:educational_app/src/pages/login/login_screen.dart';
import 'package:educational_app/src/pages/question/questions_page.dart';
import 'package:educational_app/src/pages/question/result_page.dart';
import 'package:educational_app/src/pages/question/test_overview_page.dart';
import 'package:get/get.dart';

import '../controllers/question_papers/question_paper_controller.dart';
import '../pages/question/answer_check_page.dart';
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
        GetPage(
          name: QuestionsPage.routeName,
          page: () => const QuestionsPage(),
          binding: BindingsBuilder(
            () {
              Get.put<QuestionsController>(QuestionsController());
            },
          ),
        ),
        GetPage(
          name: TestOverviewPage.routeName,
          page: () => const TestOverviewPage(),
        ),
        GetPage(
          name: ResultPage.routeName,
          page: () => const ResultPage(),
        ),
        GetPage(
          name: AnswerCheckPage.routeName,
          page: () => const AnswerCheckPage(),
        ),
      ];
}
