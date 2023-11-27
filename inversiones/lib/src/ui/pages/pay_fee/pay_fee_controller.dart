import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/pay_fee/widgets/dialog_cuota_pagada.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class PayFeeController extends GetxController {
  PayFeeController(this.appController, this.homeController);

  final AppController appController;
  final HomeController homeController;
  final Rx<PayFee> _payFee = Rx<PayFee>(PayFee());
  final Rx<int> _status = Rx<int>(0);
  final Rx<bool> _loading = Rx<bool>(true);
  final TextEditingController interestPercentage = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _loadPayFee();
    super.onInit();
  }

  Future<void> _loadPayFee() async {
    try {
      final PayFeeResponse clientsPendingInstallments =
          await const CreditHttp().infoPayFee(
        homeController.idClienteSeleccionado,
        homeController.idCredito.value,
      );
      if (clientsPendingInstallments.status == 200) {
        _payFee(clientsPendingInstallments.payFee);
        _loading(false);
      } else {
        appController.manageError(clientsPendingInstallments.message);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  }

  Future<void> pagarCuota(String tipoAbono, Size size) async {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final GenericoResponse respuestaHttp =
              await const CreditHttp().pagarCuota(
            PagarCuotaRequest(
              abonoExtra: false,
              estadoCredito: Constantes.CREDITO_ACTIVO,
              tipoAbono: tipoAbono,
              fechaAbono: General.formatoFecha(DateTime.now()),
              valorAbonado: tipoAbono == Constantes.SOLO_INTERES
                  ? General.stringToDouble(interestPercentage.text)
                  : payFee.valorCuota!,
              idCuotaCredito: payFee.id!,
            ),
          );
          if (respuestaHttp.status == 200) {
            _showInfoDialog();
          } else {
            appController.manageError(respuestaHttp.message);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  void _showInfoDialog() {
    Get.dialog(
      DialogCuotaPagada(
        accion: irAlHome,
      ),
    );
  }

  void irAlHome() {
    Get.offAllNamed(RouteNames.home);
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  int get status => _status.value;
  PayFee get payFee => _payFee.value;
  bool get loading => _loading.value;
  String get nombreCliente => homeController.nombreClienteSeleccionado;
}
