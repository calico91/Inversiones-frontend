import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class TextFieldCalendar extends StatelessWidget {
  const TextFieldCalendar({
    super.key,
    required this.controller,
    required this.onTap,
    required this.title,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.required = true,
    this.height,
    this.letterSize = 0.02,
    this.widthTextField = 0.39,
    this.mostrarBordes = true,
    this.fillColor = const Color.fromRGBO(165, 165, 165, 0.2),
  });

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
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final alturaCampo = height ?? General.mediaQuery(context).height * 0.07;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal!,
        vertical: paddingVertical!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 5),
          SizedBox(
            width: General.mediaQuery(context).width * widthTextField!,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: alturaCampo,
              ),
              child: TextFormField(
                style: TextStyle(
                  fontSize: General.mediaQuery(context).height * letterSize!,
                ),
                validator: (value) => _validateStructure(value),
                controller: controller,
                readOnly: true,
                onTap: onTap,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: ColoresApp.azulPrimario,
                  ),
                  prefixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  hintText: 'Selecciona una fecha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Colors.grey[100]!, width: 0.2),
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
          ),
        ],
      ),
    );
  }

  String? _validateStructure(String? value) {
    if (required! && value!.isEmpty) {
      return 'El campo es requerido';
    }
    return null;
  }
}
