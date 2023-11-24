import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({
    this.hintText,
    this.controller,
    this.validateText,
    required this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
  });

  final String? hintText;
  final TextEditingController? controller;
  final ValidateText? validateText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          child: TextFormField(
            textDirection: TextDirection.ltr,
            validator: (String? value) => ValidateForm().validateStructure(
              value,
              true,
              validateText!,
            ),
            inputFormatters:
                ValidateForm.validateInputFormatters(validateText!),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            maxLength: ValidateForm.validateMaxLength(validateText!),
            controller: controller,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              prefixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              suffixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: const Color.fromRGBO(165, 165, 165, 0.2),
              hintText: hintText ?? '',
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
          ),
        ),
      ],
    );
  }
}
