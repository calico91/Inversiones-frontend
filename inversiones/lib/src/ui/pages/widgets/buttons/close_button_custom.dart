import 'package:flutter/material.dart';

class CloseButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
      iconSize: 32,
      tooltip: 'Cerrar',
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.close_rounded),
      color: Colors.grey);
}
