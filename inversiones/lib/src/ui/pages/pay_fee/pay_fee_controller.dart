import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/domain/responses/pay_fee_response.dart';

import 'package:inversiones/src/ui/pages/home/home_controller.dart';

class PayFeeController extends GetxController {
  PayFeeController(this.appController, this.homeController);

  final AppController appController;
  final HomeController homeController;
  final Rx<PayFee> _payFee = Rx<PayFee>(PayFee());
  final Rx<int> _status = Rx<int>(0);
  final Rx<bool> _loading = Rx<bool>(true);

  @override
  void onInit() {
    _loadPayFee();
    super.onInit();
  }

  Future<void> _loadPayFee() async {
    try {
      final PayFeeResponse clientsPendingInstallments = await const CreditHttp()
          .infoPayFee(homeController.idClienteSeleccionado);
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

  Future<void> pagarCuota() async {
    try {
      final GenericoResponse pagarCuota = await const CreditHttp().pagarCuota(
        PagarCuotaRequest(
          fechaAbono: DateTime.now().toString(),
          valorAbono: payFee.valorCuota!,
          soloInteres: false,
          idCuotaCredito: payFee.id!,
        ),
      );
      if (pagarCuota.status == 200) {
      } else {
        appController.manageError(pagarCuota.message);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  }

  int get status => _status.value;

  PayFee get payFee => _payFee.value;
  bool get loading => _loading.value;
  String get nombreCliente => homeController.nombreClienteSeleccionado;
}
