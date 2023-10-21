// // ignore_for_file: depend_on_referenced_packages

// import 'package:core_picker/core/core_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// import 'package:talker/talker.dart';

// class Logger {
//   static final _talker = Talker(loggerSettings: _settings);
//   static final TalkerLoggerSettings _settings = TalkerLoggerSettings(
//     colors: {
//       LogLevel.info: AnsiPen()..white(),
//       LogLevel.warning: AnsiPen()..yellow(),
//       LogLevel.error: AnsiPen()..red(),
//       LogLevel.critical: AnsiPen()..rgb(r: 255, g: 165, b: 0),
//     },
//   );
//   static final String _tag = CorePicker.packageName.toUpperCase();

//   static ModuleConfig get _config => Get.find<ModuleConfig>(tag: Module.packageName);

//   static String getLogMessage(String message, String code) {
//     final logCode = "🚨 [$_tag|$code]";
//     return "$logCode|$message";
//   }

//   static void log(
//     String message, {
//     Object? error,
//     String? name,
//     StackTrace? stackTrace,
//   }) {
//     if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) {
//       final logMessage = getLogMessage(message, name ?? "LOG");
//       _talker.error(
//         logMessage,
//         error,
//         stackTrace,
//       );
//     }
//     return;
//   }

//   static logInfo(
//     String message, {
//     String name = "LOG",
//     Object? exception,
//     StackTrace? stackTrace,
//   }) {
//     if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) {
//       final logMessage = "[$_tag|$name]|$message";
//       _talker.info(
//         logMessage,
//         exception,
//         stackTrace,
//       );
//     }
//     return;
//   }

//   static logCritical(
//     String message, {
//     String name = "LOG",
//     Object? exception,
//     StackTrace? stackTrace,
//   }) {
//     if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) {
//       final logMessage = "❌ [$_tag|$name]|$message";
//       _talker.critical(
//         logMessage,
//         exception,
//         stackTrace,
//       );
//     }
//     return;
//   }

//   static logWarning(
//     String message, {
//     String name = "LOG",
//     Object? exception,
//     StackTrace? stackTrace,
//   }) {
//     if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) {
//       final logMessage = "⚠️ [$_tag|$name]|$message";
//       _talker.warning(
//         logMessage,
//         exception,
//         stackTrace,
//       );
//     }
//     return;
//   }

//   static logOK(
//     String message, {
//     String name = "LOG",
//     Object? exception,
//     StackTrace? stackTrace,
//   }) {
//     if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) {
//       final logMessage = "✅ [$_tag|$name]|$message";
//       _talker.fine(
//         logMessage,
//         exception,
//         stackTrace,
//       );
//     }
//     return;
//   }
// }

import 'package:core_picker/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talker/talker.dart';

class Logger {
  static final _talker = Talker();
  // static final TalkerLoggerSettings _settings = TalkerLoggerSettings(
  //   colors: {
  //     LogLevel.info: AnsiPen()..white(),
  //     LogLevel.warning: AnsiPen()..yellow(),
  //     LogLevel.error: AnsiPen()..red(),
  //     LogLevel.critical: AnsiPen()..rgb(r: 255, g: 165, b: 0),
  //   },
  // );
  static final String _tag = CorePicker.packageName.toUpperCase();
  static String getLogMessage(String message, String code) {
    final logCode = "🚨 [$_tag|$code]";
    return "$logCode|$message";
  }

  static final ModuleConfig _config =
      Get.find<ModuleConfig>(tag: CorePicker.packageName);
  static void log(
    String message, {
    Object? error,
    String? name,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _config.isShowLog) {
      final logMessage = getLogMessage(message, name ?? "LOG");
      _talker.error(
        logMessage,
        error,
        stackTrace,
      );
    }
    return;
  }

  static logInfo(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _config.isShowLog) {
      final logMessage = "[$_tag|$name]|$message";
      _talker.info(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logCritical(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _config.isShowLog) {
      final logMessage = "❌ [$_tag|$name]|$message";
      _talker.critical(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logWarning(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _config.isShowLog) {
      final logMessage = "⚠️ [$_tag|$name]|$message";
      _talker.warning(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logOK(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _config.isShowLog) {
      final logMessage = "✅ [$_tag|$name]|$message";
      _talker.good(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }
}
