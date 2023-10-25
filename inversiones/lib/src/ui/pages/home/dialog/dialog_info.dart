import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/add_credit_response.dart';

class DialogInfo extends StatelessWidget {
  final String title;
  final DataCreditResponse info;

  const DialogInfo({
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          Text('Primera Cuota:${info.valorPrimerCuota}'),
          Text('Cantidad cuotas:${info.cantidadCuotas}'),
          Text('Valor cuotas:${info.valorCuotas}'),
          Text('Fecha pago:${info.fechaPago}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
