import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch(
      {super.key, required this.labelText,
      required this.onChanged,
      this.controller,
      this.widthTextFieldSearch = 0.91});

  final String labelText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final double? widthTextFieldSearch;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: General.mediaQuery(context).width * widthTextFieldSearch!,
        child: TextField(
          controller: controller,
          onChanged: (String? value) {
            if (value != null) {
              final cleanValue = General.removerCaracteresEspeciales(value);
              controller?.text = cleanValue;

              onChanged.call(cleanValue);
            }
          },
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      );
}
