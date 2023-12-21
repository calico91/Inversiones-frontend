import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class TextFieldCalendar extends StatelessWidget {
  const TextFieldCalendar({
    required this.controller,
    required this.onTap,
    required this.title,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.required = true,
    this.height,
  });

  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final bool? required;
  final double? height;

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
            width: General.mediaQuery(context).width * 0.39,
            height: height ?? General.mediaQuery(context).height * 0.07,
            child: TextFormField(
              validator: (value) => _validateStructure(value),
              controller: controller,
              decoration: InputDecoration(
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
                  Icons.calendar_today,
                  color: Colors.blue,
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
