import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/add_credit_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

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
            _showInfoCredito('Fecha pago', info.fechaPago!),
            _showInfoCredito(
              'Valor credito',
              General.formatoMoneda(double.parse(info.valorCredito!)),
            ),
            _showInfoCredito(
              'Valor cuotas',
              General.formatoMoneda(double.parse(info.valorCuotas!)),
            ),
            _showInfoCredito('Cantidad cuotas', info.cantidadCuotas!),
            _showInfoCredito(
              'Valor primer cuota',
              General.formatoMoneda(double.parse(info.valorPrimerCuota!)),
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

  Widget _showInfoCredito(
    String title,
    String info,
  ) {
    return Row(
      children: [
        Text('$title:', textAlign: TextAlign.left),
        Expanded(child: Container()),
        Text(
          info,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
