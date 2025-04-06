import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class TextFieldCalendar extends StatelessWidget {
  const TextFieldCalendar(
      {super.key, required this.controller,
      required this.onTap,
      required this.title,
      this.paddingVertical = 0,
      this.paddingHorizontal = 0,
      this.required = true,
      this.height,
      this.letterSize = 0.02,
      this.widthTextField = 0.39,
      this.mostrarBordes = true});

  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final bool? required;
  final double? height;
  final bool? mostrarBordes;
  final double? widthTextField;
  final double? letterSize;

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
          Text(title),
          SizedBox(
            height: General.mediaQuery(context).height * 0.005,
          ),
          SizedBox(
            width: General.mediaQuery(context).width * widthTextField!,
            height: height ?? General.mediaQuery(context).height * 0.07,
            child: TextFormField(
              style: TextStyle(
                  fontSize: General.mediaQuery(context).height * letterSize!),
              validator: (value) => _validateStructure(value),
              controller: controller,
              decoration: mostrarBordes!
                  ? InputDecoration(
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
                      prefixIcon: const Icon(
                        size: 30,
                        Icons.calendar_today,
                        color: ColoresApp.azulPrimario,
                      ),
                    )
                  : const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: ColoresApp.azulPrimario,
                      ),
                    ),
              readOnly: true,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }

  ///valida estructuras
  String? _validateStructure(String? value) {
    if (required! && value!.isEmpty) {
      return 'El campo requerido';
    }
    return null;
  }
}
