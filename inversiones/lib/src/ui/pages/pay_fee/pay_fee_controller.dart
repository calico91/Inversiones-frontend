import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/abono_response.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';

class PayFeeController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeController homeController = Get.find<HomeController>();
  final Rx<PayFee> _payFee = Rx<PayFee>(PayFee());
  final Rx<int> _status = Rx<int>(0);
  final TextEditingController valorAbono = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<bool> cambiarCuota = Rx<bool>(false);

  Future<void> loadPayFee() async {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final PayFeeResponse clientsPendingInstallments =
                await const CreditHttp().infoPayFee(
              homeController.idClienteSeleccionado,
              homeController.idCredito.value,
            );
            _payFee(clientsPendingInstallments.payFee);
            Get.toNamed(RouteNames.payFee);
          } on HttpException catch (e) {
            Get.back();
            appController.manageError(e.message);
          } catch (e) {
            Get.back();

            appController.manageError(e.toString());
          }
        });
  }

  Future<void> pagarCuota(String tipoAbono) async {
    Get.showOverlay(
      loadingWidget: const CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final AbonoResponse respuestaHttp =
              await const CreditHttp().pagarCuota(
            PagarCuotaRequest(
              abonoExtra: false,
              estadoCredito: Constantes.CREDITO_ACTIVO,
              tipoAbono: tipoAbono,
              fechaAbono: General.formatoFecha(DateTime.now()),

              /// si solo abona interes, envia el valor del input
              /// si al pagar la cuota normal activa el boton de cambiar valor se envia el valor del input
              /// si no lo cambia envia el valor que viene del back
              valorAbonado: tipoAbono == Constantes.SOLO_INTERES
                  ? General.stringToDouble(valorAbono.text)
                  : cambiarCuota.value
                      ? General.stringToDouble(valorAbono.text)
                      : payFee.valorCuota!,
              idCuotaCredito: payFee.id!,
            ),
          );
          
          General.mostrarModalCompartirAbonos(respuestaHttp.dataAbono!, false,
              homeController.nombreClienteSeleccionado, false);
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  /// cambia el valor del switch modificar valor
  bool? cambiarValorSwitch(bool value) {
    return cambiarCuota.value = value;
  }

  int get status => _status.value;
  PayFee get payFee => _payFee.value;
  String get nombreCliente => homeController.nombreClienteSeleccionado;
}
