import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({
    super.key,
    this.hintText,
    required this.validateText,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.fillColor,
    this.widthTextField = 0.73,
    this.title = '',
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.textAlign = TextAlign.left,
  });

  final String? hintText;
  final TextEditingController? controller;
  final ValidateText validateText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? fillColor;
  final double widthTextField;
  final String title;
  final AutovalidateMode autovalidateMode;
  final void Function(String)? onChanged;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, textAlign: textAlign),
        const SizedBox(height: 5),
        SizedBox(
          width: General.mediaQuery(context).width * widthTextField,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: TextInputType.text,
            autovalidateMode: autovalidateMode,
            inputFormatters: ValidateForm.validateInputFormatters(validateText),
            textAlign: textAlign,
            maxLength: ValidateForm.validateMaxLength(validateText),
            validator: (value) =>
                ValidateForm().validateStructure(value, true, validateText),
            onChanged: (value) {
              final cleanValue = General.removerCaracteresEspeciales(value);
              controller?.text = cleanValue;
              controller?.selection = TextSelection.fromPosition(
                TextPosition(offset: controller!.text.length),
              );
              onChanged?.call(cleanValue);
            },
            decoration: InputDecoration(
              prefixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              suffixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: fillColor ?? const Color.fromRGBO(165, 165, 165, 0.2),
              hintText: hintText ?? '',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[100]!, width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFF1B80BF),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
