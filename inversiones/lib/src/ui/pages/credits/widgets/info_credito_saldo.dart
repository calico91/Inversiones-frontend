import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class InfoCreditoSaldoModal extends StatelessWidget {
  final String title;
  final InfoCreditoySaldo info;
  final VoidCallback? accion;

  const InfoCreditoSaldoModal({
    required this.title,
    required this.info,
    this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Informacion credito',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.27,
        child: Column(
          children: [
            _showInfoCredito('Numero cuotas', info.numeroCuotas!.toString()),
            _showInfoCredito('Cuota numero', info.cuotaNumero!.toString()),
            _showInfoCredito(
                'Interes', '${info.interesPorcentaje!.toStringAsFixed(0)}%'),
            _showInfoCredito('Fecha credito', info.fechaCredito!),
            _showInfoCredito('Fecha cuota', info.fechaCuota!),
            _showInfoCredito('Ultima pagada', info.ultimaCuotaPagada!),
            _showInfoCredito(
              'Valor credito',
              General.formatoMoneda(info.valorCredito),
            ),
            _showInfoCredito(
              'Valor cuota',
              General.formatoMoneda(info.valorCuota),
            ),
            _showInfoCredito(
              'Valor interes',
              General.formatoMoneda(info.valorInteres),
            ),
            _showInfoCredito(
              'Interes a hoy',
              General.formatoMoneda(info.interesHoy),
            ),
            _showInfoCredito(
              'Saldo credito',
              General.formatoMoneda(info.saldoCredito),
            ),
            _showInfoCredito(
              'Capital pagado',
              General.formatoMoneda(info.capitalPagado),
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
  ) =>
      Row(
        children: [
          Text('$title:',
              textAlign: TextAlign.left, overflow: TextOverflow.ellipsis),
          Expanded(child: Container()),
          Text(
            info,
            textAlign: TextAlign.right,
          ),
        ],
      );
}
