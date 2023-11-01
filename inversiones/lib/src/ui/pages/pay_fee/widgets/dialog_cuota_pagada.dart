import 'package:flutter/material.dart';

class DialogCuotaPagada extends StatelessWidget {
  const DialogCuotaPagada();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        textAlign: TextAlign.center,
        'Cuota cancelada correctamente',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
