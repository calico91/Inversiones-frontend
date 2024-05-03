import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';
import 'package:inversiones/src/ui/pages/reportes/widgets/capital_interes/card_capital_interes.dart';
import 'package:inversiones/src/ui/pages/reportes/widgets/ultimos_abonos/card_ultimos_abonos.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar_style/tittle_appbar.dart';

class ReportesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReportesController controller = Get.find<ReportesController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white12,
          title: Padding(
            padding:
                EdgeInsets.only(left: General.mediaQuery(context).width * 0.22),
            child: const TittleAppbar('Reportes'),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardCapitalInteres(controller),
            CardUltimosAbonos(controller),
          ],
        ),
      ),
    );
  }
}
