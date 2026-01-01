import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[LOG] $message');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }
}
