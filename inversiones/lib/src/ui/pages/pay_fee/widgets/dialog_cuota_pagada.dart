import 'package:flutter/material.dart';

class DialogCuotaPagada extends StatelessWidget {
  const DialogCuotaPagada({required this.accion});
  final VoidCallback accion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        textAlign: TextAlign.center,
        'Cuota cancelada correctamente',
      ),
      actions: [
        TextButton(
          onPressed: () => accion(),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
