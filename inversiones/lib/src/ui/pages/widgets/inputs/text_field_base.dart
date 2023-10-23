import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/validate_exp_reg.dart';

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
  });

  final String? hintText;
  final String title;
  final TextEditingController? controller;
  final ValidateText? validateText;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? widthTextField;
  final double? heightTextField;
  final TextInputType textInputType;
  final bool? required;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
            height: size.height * heightTextField!,
            width: size.width * widthTextField!,
            child: TextFormField(
              key: key,
              expands: true,
              maxLines: null,
              validator: (String? value) => _validateStructure(value),
              inputFormatters: [_validateInputFormatters()],
              keyboardType: textInputType,
              textAlign: TextAlign.right,
              maxLength: _validateMaxLength(),
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

  ///valida cantidad de caracteres
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
      case ValidateText.name:
        return 30;
      case ValidateText.onlyNumbers:
        return 20;
      case ValidateText.phoneNumber:
        return 10;
      case ValidateText.observations:
        return 250;
      default:
        return 64;
    }
  }

  /// valida tipo de datos que se ingresan
  TextInputFormatter _validateInputFormatters() {
    switch (validateText) {
      case ValidateText.creditValue:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.installmentAmount:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.interestPercentage:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.onlyNumbers:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.phoneNumber:
        return FilteringTextInputFormatter.digitsOnly;
      default:
        return FilteringTextInputFormatter.singleLineFormatter;
    }
  }

  ///valida estructuras
  String? _validateStructure(String? value) {
    if (required! && value!.isEmpty) {
      return 'El campo requerido';
    } else {
      switch (validateText) {
        case ValidateText.email:
          return validateEmail(value!) ? null : message('email');
        case ValidateText.phoneNumber:
          return validateNumberPhone(value!) ? null : message('celular');
        default:
          return null;
      }
    }
  }

  String message(String type) => '$type es incorrecto';
}
