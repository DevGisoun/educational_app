import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:educational_app/src/pages/home/home_screen.dart';
import 'package:educational_app/src/pages/login/login_screen.dart';
import 'package:educational_app/src/utils/app_logger.dart';
import 'package:educational_app/src/widgets/dialogs/dialog_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  /// App 실행 시 사용자 로그인 여부 체크
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  /// 1초 딜레이 후 Introduction 페이지 이동
  void initAuth() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    /// Firebase Auth 인스턴스 초기화
    _auth = FirebaseAuth.instance;

    /// User 로그인 상태 변경 관리
    _authStateChanges = _auth.authStateChanges();
    // User 정보 존재 시 User Class에 추가
    _authStateChanges.listen(
      (User? user) {
        _user.value = user;
      },
    );
    navToIntroduction();
  }

  /// Introduction 페이지 이동 후 History 전체 삭제
  void navToIntroduction() {
    Get.offAllNamed('/introduction');
  }

  signinWithGoogle() async {
    final GoogleSignIn _googleSignin = GoogleSignIn();

    try {
      GoogleSignInAccount? account = await _googleSignin.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRef.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'profilepic': account.photoUrl,
      'github': '',
      'website': '',
    });
  }

  Future<void> signOut() async {
    AppLogger.d('Sign Out');

    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseException catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.questionStartDialog(
        onTap: () {
          // 로그인 페이지로 이동
          Get.back();
          navigateToLoginPage();
        },
      ),
      barrierDismissible: false,
    );
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
