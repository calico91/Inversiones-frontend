import 'package:flutter/material.dart';

class CloseButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Cerrar',
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close_rounded),
        color: Colors.blue);
  }
}
