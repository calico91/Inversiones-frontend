import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class DialogInfoCredito extends StatelessWidget {
  final String title;
  final DataCreditResponse? info;
  final VoidCallback accion;

  const DialogInfoCredito({
    required this.title,
    this.info,
    required this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.11,
        child: info == null
            // ignore: sized_box_shrink_expand
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Column(
                children: [
                  _showInfoCredito('Fecha pago', info!.fechaPago!),
                  _showInfoCredito(
                    'Valor credito',
                    General.formatoMoneda(double.parse(info!.valorCredito!)),
                  ),
                  _showInfoCredito(
                    'Valor cuotas',
                    General.formatoMoneda(double.parse(info!.valorCuotas!)),
                  ),
                  _showInfoCredito('Cantidad cuotas', info!.cantidadCuotas!),
                  _showInfoCredito(
                    'Valor primer cuota',
                    General.formatoMoneda(
                      double.parse(info!.valorPrimerCuota!),
                    ),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => accion(),
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

  void irAlHome() {
    Get.offAllNamed(RouteNames.home);
  }
}
