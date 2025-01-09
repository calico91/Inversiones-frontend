import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';

class InformacionCapitalInteres extends StatelessWidget {
  const InformacionCapitalInteres(this.info);

  final ReporteInteresyCapital info;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      elevation: 10,
      title: const Text('Información de ingresos'),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.24,
        child: Column(
          children: [
            _divider(),
            _mostrarInformacionIngresos('Valor interes',
                interesMes: info.valorInteres ?? 0),
            _divider(),
            _mostrarInformacionIngresos('Valor capital',
                capitalMes: info.valorCapital ?? 0),
            _divider(),
            _mostrarInformacionIngresos('Valor total',
                capitalMes: info.valorCapital ?? 0,
                interesMes: info.valorInteres ?? 0),
            _divider()
          ],
        ),
      ),
      actions: const [CloseButtonCustom()],
    );
  }

  Widget _divider() => const Divider();

  Widget _mostrarInformacionIngresos(String mensaje,
          {double? interesMes, double? capitalMes}) =>
      Column(
        children: [
          Text(mensaje, style: const TextStyle(fontSize: 20)),
          Text(
            General.formatoMoneda(
              (interesMes ?? 0) + (capitalMes ?? 0),
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      );
}
