import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoSnackbar extends GetSnackBar {
  const InfoSnackbar(String message) : super(message: message);

  @override
  Widget? get messageText {
    return SelectableText(
      message!,
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  SnackPosition get snackPosition => SnackPosition.TOP;

  @override
  Color get backgroundColor => Colors.blueGrey;

  @override
  Duration? get duration => const Duration(seconds: 10);

  @override
  Widget? get icon => const Icon(Icons.error_outlined, color: Colors.white);

  @override
  Widget? get mainButton {
    return IconButton(
       color: Colors.white,
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close),
    );
  }

    @override
  double get borderRadius => 15;
}
