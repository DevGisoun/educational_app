import 'package:get/get.dart';

class AuthController extends GetxController {
  /// App 실행 시 사용자 로그인 여부 체크
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  /// 1초 딜레이 후 Introduction 페이지 이동
  void initAuth() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    navToIntroduction();
  }

  /// 페이지 이동 후 History 전체 삭제
  void navToIntroduction() {
    Get.offAllNamed('/introduction');
  }
}
