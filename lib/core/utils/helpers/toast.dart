import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toast {
  static void success({String message = 'Thành công'}) {
    Get.snackbar(
      'Thông báo',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
    );
  }

  static void error({String message = 'Có lỗi xảy ra'}) {
    Get.snackbar(
      'Thông báo',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
    );
  }
}
