import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class InformacionCapitalInteres extends StatelessWidget {
  const InformacionCapitalInteres(this.info);

  final ReporteInteresyCapital info;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text(
              'Interes',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              General.formatoMoneda(info.interesMes ?? 0),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Column(
          children: [
            const Text('Capital', style: TextStyle(fontSize: 20)),
            Text(
              General.formatoMoneda(info.capitalMes ?? 0),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Column(
          children: [
            const Text('Total', style: TextStyle(fontSize: 20)),
            Text(
              General.formatoMoneda(
                (info.interesMes ?? 0) + (info.capitalMes ?? 0),
              ),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
