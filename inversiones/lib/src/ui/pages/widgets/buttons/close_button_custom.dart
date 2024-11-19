import 'package:flutter/material.dart';

class CloseButtonCustom extends StatelessWidget {
final VoidCallback? accion;

  const CloseButtonCustom({this.accion});

  @override
  Widget build(BuildContext context) => IconButton(
      iconSize: 32,
      tooltip: 'Cerrar',
      onPressed: () {
        accion?.call();
        return Navigator.pop(context);
      },
      icon: const Icon(Icons.close_rounded),
      color: Colors.grey);
}
