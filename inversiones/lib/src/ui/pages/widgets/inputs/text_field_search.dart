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
        suffixIcon: _cambiarIconoCampoBuscar(),
      ),
    );
  }

  //TODO implementar al dar en la X que se borre lo que busco
  Widget _cambiarIconoCampoBuscar() {
    if (controller!.value.text.isEmpty) {
      return const Icon(Icons.search);
    } else {
      return IconButton(
        splashRadius: 1,
        icon: const Icon(Icons.cancel_sharp),
        onPressed: () {
          const Icon(Icons.search);
          return;
        },
      );
    }
  }
}
