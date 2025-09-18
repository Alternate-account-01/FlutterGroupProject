import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void show(
    String title,
    String message, {
    Color bgColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      colorText: Colors.white,
      duration: duration,
      animationDuration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      mainButton: (actionLabel != null && onAction != null)
          ? TextButton(
              onPressed: () {
                onAction();
                if (Get.isSnackbarOpen) Get.back();
              },
              child: Text(
                actionLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
