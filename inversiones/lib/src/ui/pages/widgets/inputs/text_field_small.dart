import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldSmall extends StatelessWidget {
  const TextFieldSmall({
    super.key,
    this.hintText = '',
    required this.controller,
    this.validateText,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.widthTextField = 0.002,
    this.heightTextField = 0.002,
    this.required = true,
    this.textAlign = TextAlign.right,
  });

  final String? hintText;
  final TextEditingController controller;
  final ValidateText? validateText;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? widthTextField;
  final double? heightTextField;
  final TextAlign? textAlign;
  final bool? required;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 40,
      textDirection: TextDirection.ltr,
      expands: true,
      maxLines: null,
      validator: (String? value) =>
          ValidateForm().validateStructure(value, required!, validateText!),
      inputFormatters: ValidateForm.validateInputFormatters(validateText!),
      keyboardType: TextInputType.number,
      textAlign: textAlign!,
      maxLength: ValidateForm.validateMaxLength(validateText!),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
