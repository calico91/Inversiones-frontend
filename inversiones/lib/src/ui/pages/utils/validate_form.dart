import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/validate_exp_reg.dart';

class ValidateForm {
  ///valida cantidad de caracteres
  static int? validateMaxLength(ValidateText validateText) {
    switch (validateText) {
      case ValidateText.email:
        return 64;
      case ValidateText.creditValue:
        return 9;
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
      case ValidateText.date:
        return 10;
      case ValidateText.username:
        return null;
      case ValidateText.password:
        return null;
      default:
        return 64;
    }
  }

  /// valida tipo de datos que se ingresan
  static List<TextInputFormatter> validateInputFormatters(
    ValidateText validateText,
  ) {
    switch (validateText) {
      case ValidateText.creditValue:
        return [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyTextInputFormatter(
            symbol: '',
            decimalDigits: 0,
          ),
        ];
      case ValidateText.installmentAmount:
        return [FilteringTextInputFormatter.digitsOnly];
      case ValidateText.interestPercentage:
        return [FilteringTextInputFormatter.digitsOnly];
      case ValidateText.onlyNumbers:
        return [FilteringTextInputFormatter.digitsOnly];
      case ValidateText.phoneNumber:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return [FilteringTextInputFormatter.singleLineFormatter];
    }
  }

  ///valida estructuras
  String? validateStructure(
    String? value,
    bool required,
    ValidateText validateText,
  ) {
    if (required && value!.isEmpty) {
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
