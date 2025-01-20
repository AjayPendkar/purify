import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastMessage {
  static void show(String message, {bool isError = false}) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.only(
        bottom: 16,
        left: 32,
        right: 32,
      ),
      borderRadius: 0,
      backgroundColor: isError ? Colors.red : Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCirc,
    );
  }
} 