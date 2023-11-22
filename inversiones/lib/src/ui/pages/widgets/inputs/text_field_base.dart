import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldBase extends StatelessWidget {
  const TextFieldBase({
    super.key,
    this.hintText = '',
    required this.title,
    this.controller,
    required this.textInputType,
    this.validateText,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.widthTextField = 0.39,
    this.heightTextField = 0.09,
    this.required = true,
    this.textAlign = TextAlign.right,
    this.moneyCamp = false,
  });

  final String? hintText;
  final String title;
  final TextEditingController? controller;
  final ValidateText? validateText;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? widthTextField;
  final double? heightTextField;
  final TextAlign? textAlign;
  final TextInputType textInputType;
  final bool? required;
  final bool? moneyCamp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal!,
        vertical: paddingVertical!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, textAlign: TextAlign.right),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: General.mediaQuery(context).height * heightTextField!,
            width: General.mediaQuery(context).width * widthTextField!,
            child: TextFormField(
              textDirection: TextDirection.ltr,
              expands: true,
              maxLines: null,
              validator: (String? value) => ValidateForm()
                  .validateStructure(value, required!, validateText!),
              inputFormatters:
                  ValidateForm.validateInputFormatters(validateText!),
              keyboardType: textInputType,
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
            ),
          ),
        ],
      ),
    );
  }
}
