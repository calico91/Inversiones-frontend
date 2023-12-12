import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/reportes_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ReportesController extends GetxController {
  ReportesController(this.appController);

  final AppController appController;

  final TextEditingController fechaInicial = TextEditingController();
  final TextEditingController fechaFinal = TextEditingController();
  final Rx<ReporteInteresyCapital> infoInteresCapital =
      Rx(ReporteInteresyCapital());

  @override
  void onInit() {
    _fechaInicial();

    super.onInit();
  }

  Future<void> consultarCapitalInteres(Size size) async {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final ReporteInteresyCapitalResponse resHttp =
              await const ReportesHttp().infoReporteInteresyCapital(
            fechaInicial.text,
            fechaFinal.text,
          );
          if (resHttp.status == 200) {
            print(resHttp.reporteInteresyCapital!.capitalMes);
            print(resHttp.reporteInteresyCapital!.interesMes);
            infoInteresCapital(resHttp.reporteInteresyCapital);
          } else {
            appController.manageError(resHttp.message!);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  void _fechaInicial() {
    fechaInicial.text = General.formatoFecha(DateTime.now());
    fechaFinal.text = General.formatoFecha(DateTime.now());
  }
}
