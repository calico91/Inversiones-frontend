import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorSnackbar extends GetSnackBar {
  const ErrorSnackbar(String message) : super(message: message);

  @override
  Widget? get messageText {
    return SelectableText(
      message!,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  SnackPosition get snackPosition => SnackPosition.TOP;

  @override
  Color get backgroundColor => Colors.redAccent;

  @override
  Duration? get duration => const Duration(seconds: 5);

  @override
  Widget? get icon => const Icon(Icons.error_outlined, color: Colors.white);

  @override
  Widget? get mainButton {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close),
    );
  }
}
