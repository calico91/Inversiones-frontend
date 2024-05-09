import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/reportes_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:lottie/lottie.dart';

class ReportesController extends GetxController {
  ReportesController(this.appController);

  final AppController appController;

  final TextEditingController fechaInicial = TextEditingController();
  final TextEditingController fechaFinal = TextEditingController();
  final Rx<ReporteInteresyCapital> infoInteresCapital =
      Rx(ReporteInteresyCapital());
  final Rx<List<AbonosRealizados>> ultimosAbonos = Rx([]);

  final Rx<bool> fechasCorrectas = Rx(true);

  final TextEditingController cantidadAbonosConsultar = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _fechaInicial();
    cantidadAbonosConsultar.text = '10';
    super.onInit();
  }

  Future<void> consultarCapitalInteres() async {
    _validarFechasCorrectas();
    if (fechasCorrectas.value) {
      Get.showOverlay(
        loadingWidget: Lottie.asset(Constantes.CARGANDO),
        asyncFunction: () async {
          try {
            final ReporteInteresyCapitalResponse resHttp =
                await const ReportesHttp().consultarReporteInteresyCapital(
              fechaInicial.text,
              fechaFinal.text,
            );
            if (resHttp.status == 200) {
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
  }

  Future<void> consultarUltimosAbonos() async {
    Get.showOverlay(
      loadingWidget:Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final AbonosRealizadosResponse resHttp =
              await const ReportesHttp().consultarUltimosAbonos(
            int.parse(cantidadAbonosConsultar.value.text),
          );
          if (resHttp.status == 200) {
            ultimosAbonos(resHttp.abonosRealizados);
            cantidadAbonosConsultar.clear();
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

  void _validarFechasCorrectas() {
    DateTime.parse(fechaInicial.text)
                .compareTo(DateTime.parse(fechaFinal.text)) >
            0
        ? fechasCorrectas(false)
        : fechasCorrectas(true);
  }
}
