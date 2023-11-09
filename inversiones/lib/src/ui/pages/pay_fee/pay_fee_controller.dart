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

  Future<void> pagarCuota(bool soloInteres) async {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
      asyncFunction: () async {
        try {
          final GenericoResponse respuestaHttp =
              await const CreditHttp().pagarCuota(
            PagarCuotaRequest(
              tipoAbono: soloInteres ? 'SI' : 'CN',
              fechaAbono: General.formatoFecha(DateTime.now()),
              valorAbonado: soloInteres
                  ? General.stringToDouble(interestPercentage.text)
                  : payFee.valorCuota!,
              soloInteres: soloInteres,
              idCuotaCredito: payFee.id!,
            ),
          );
          if (respuestaHttp.status == 200) {
            await Future.delayed(const Duration(seconds: 5));
            _showInfoDialog();
            homeController.loadClientsPendingInstallments();
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
      const DialogCuotaPagada(),
    );
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  int get status => _status.value;

  PayFee get payFee => _payFee.value;
  bool get loading => _loading.value;
  String get nombreCliente => homeController.nombreClienteSeleccionado;
}
