import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({
    this.hintText,
    this.controller,
    this.validateText,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.fillColor,
    this.widthTextField = 0.73,
    this.title = '',
  });

  final String? hintText;
  final TextEditingController? controller;
  final ValidateText? validateText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Color? fillColor;
  final double? widthTextField;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, textAlign: TextAlign.right),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: General.mediaQuery(context).width * widthTextField!,
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
            onChanged: (String? value) {
              if (value != null) {
                final cleanValue = General.removerCaracteresEspeciales(value);
                controller?.text = cleanValue;
              }
            },
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              prefixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              suffixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: fillColor ?? const Color.fromRGBO(165, 165, 165, 0.2),
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
