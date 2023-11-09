import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    required this.labelText,
    required this.onChanged,
    this.controller,
  });
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
