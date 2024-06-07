import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactiveTextEditingController {
  final TextEditingController controller;
  RxString text = ''.obs;

  ReactiveTextEditingController({String initialText = ''})
      : controller = TextEditingController(text: initialText) {
    text.value = initialText;
    controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    text.value = controller.text;
  }

  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose();
  }
}
