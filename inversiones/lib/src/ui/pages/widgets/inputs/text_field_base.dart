import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';

class TextFielBase extends StatelessWidget {
  const TextFielBase({
    required this.hintText,
    required this.controller,
    this.validateText,
    this.paddingVertical = 10,
    this.paddingHorizontal = 200,
  });

  final String hintText;
  final TextEditingController controller;
  final ValidateText? validateText;
  final double? paddingVertical;
  final double? paddingHorizontal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal!,
        vertical: paddingVertical!,
      ),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.right,
            maxLength: _validateMaxLength(),
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
        ],
      ),
    );
  }

  int _validateMaxLength() {
    switch (validateText) {
      case ValidateText.email:
        return 64;
      case ValidateText.creditValue:
        return 7;
      case ValidateText.installmentAmount:
        return 2;
      case ValidateText.interestPercentage:
        return 2;
      default:
        return 64;
    }
  }
}
