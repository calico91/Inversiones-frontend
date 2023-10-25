import 'package:flutter/material.dart';

class TextFieldCalendar extends StatelessWidget {
  const TextFieldCalendar({
    required this.controller,
    required this.onTap,
    required this.title,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.required = true,
  });

  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double? paddingVertical;
  final double? paddingHorizontal;
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
          Text(title),
          SizedBox(
            width: size.width * 0.39,
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
                  color: Colors.grey,
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
