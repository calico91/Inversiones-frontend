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
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: size.height * 0.11,
        child: Column(
          children: [
            _showInfoCredito(
              'Fecha pago',
              info.fechaPago!,
              false,
            ),
            _showInfoCredito(
              'Valor credito',
              info.valorCredito!,
              true,
            ),
            _showInfoCredito(
              'Valor cuotas',
              info.valorCuotas!,
              true,
            ),
            _showInfoCredito(
              'Cantidad cuotas',
              info.cantidadCuotas!,
              false,
            ),
            _showInfoCredito(
              'Valor primer cuota',
              info.valorPrimerCuota!,
              true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

  Widget _showInfoCredito(String title, String info, bool money) {
    return Row(
      children: [
        Text('$title:', textAlign: TextAlign.left),
        Expanded(child: Container()),
        // ignore: prefer_if_elements_to_conditional_expressions
        money
            ? Text(
                '\$$info',
                textAlign: TextAlign.right,
              )
            : Text(
                info,
                textAlign: TextAlign.right,
              ),
      ],
    );
  }
}
