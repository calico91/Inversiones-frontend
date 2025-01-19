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
    this.enabled = true,
    this.onChanged,
    this.readOnly = false,
    this.expands = false,
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
  final bool? enabled;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final bool? expands;
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
              readOnly: readOnly!,
              onChanged: (String? value) {
                if (value != null) {
                  final cleanValue = General.removerCaracteresEspeciales(value);
                  controller?.text = cleanValue;

                  onChanged?.call(cleanValue);
                }
              },
              enabled: enabled,
              expands: expands!,
              maxLines: expands! ? null : 1,
              validator: (String? value) => ValidateForm()
                  .validateStructure(value, required!, validateText!),
              inputFormatters:
                  ValidateForm.validateInputFormatters(validateText!),
              keyboardType: textInputType,
              textAlign: textAlign!,
              maxLength: ValidateForm.validateMaxLength(validateText!),
              controller: controller,
              decoration: InputDecoration(
                fillColor: readOnly! ? Colors.grey.shade300 : Colors.white,
                filled: true,
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
