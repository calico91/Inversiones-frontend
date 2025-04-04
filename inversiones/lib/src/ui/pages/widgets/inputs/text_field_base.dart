import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldBase extends StatelessWidget {
  const TextFieldBase({
    super.key,
    this.hintText = '',
    this.title = '',
    this.controller,
    required this.textInputType,
    this.validateText,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.widthTextField = 0.39,
    this.heightTextField,
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
          const SizedBox(height: 5),
          SizedBox(
            height: heightTextField != null
                ? General.mediaQuery(context).height * heightTextField!
                : null,
            width: General.mediaQuery(context).width * widthTextField!,
            child: TextFormField(
              readOnly: readOnly!,
              onChanged: (value) {
                // se llama la función externa si existe
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              enabled: enabled,
              expands: expands!,
              maxLines: expands! ? null : 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => ValidateForm()
                  .validateStructure(value, required!, validateText!),
              inputFormatters:
                  ValidateForm.validateInputFormatters(validateText!),
              keyboardType: textInputType,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              maxLength: ValidateForm.validateMaxLength(validateText!),
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                fillColor: readOnly!
                    ? Colors.grey.shade300
                    : const Color.fromRGBO(165, 165, 165, 0.15),
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(
                  letterSpacing: 0.2,
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
      ),
    );
  }
}
