import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';
import 'package:inversiones/src/ui/pages/reportes/widgets/capital_interes/card_capital_interes.dart';
import 'package:inversiones/src/ui/pages/reportes/widgets/ultimos_abonos/card_ultimos_abonos.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';

class ReportesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReportesController controller = Get.find<ReportesController>();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarCustom('Reportes'),
        body: SingleChildScrollView(
            child: Column(children: [
          CardCapitalInteres(controller),
          CardUltimosAbonos(controller)
        ])));
  }
}
