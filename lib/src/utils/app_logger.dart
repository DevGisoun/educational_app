import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // 표시할 메서드 호출 수
      errorMethodCount: 8, // Stack Trace가 Provide 된 경우 메서드 호출 수
      lineLength: 200,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static void i(dynamic msg) {
    logger.i(msg);
  }

  static void d(dynamic msg) {
    logger.d(msg);
  }

  static void w(dynamic msg) {
    logger.w(msg);
  }

  static void e(dynamic msg) {
    logger.e(msg);
  }

  static void wtf(dynamic msg) {
    logger.wtf(msg);
  }
}
