import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_creditos_activos.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_info_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_response_general.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/info_credito_saldo.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/pay_fee/widgets/dialog_cuota_pagada.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class CreditsController extends GetxController {
  CreditsController(this.appController);

  final AppController appController;
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAbonoCapital = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final TextEditingController abonar = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController installmentDate = TextEditingController();
  final TextEditingController creditDate = TextEditingController();
  final TextEditingController nuevaFechaCuota = TextEditingController();
  TextEditingController buscar = TextEditingController();
  final Rx<int> status = Rx(0);
  final Rx<List<InfoCreditosActivos>> creditosActivos =
      Rx<List<InfoCreditosActivos>>([]);

  final Rx<int> idCuotaSeleccionada = Rx(0);
  final Rx<bool> modalidad = Rx<bool>(true);

  Rx<List<InfoCreditosActivos>> filtroCreditos =
      Rx<List<InfoCreditosActivos>>([]);

  Rx<InfoCreditoySaldo> infoCreditoSaldo =
      Rx<InfoCreditoySaldo>(InfoCreditoySaldo());

  @override
  Future<void> onInit() async {
    _fechaInicialCredito();
    _cedulaCliente();

    await _infoCreditosActivos();
    filtroCreditos(creditosActivos.value);

    super.onInit();
  }

  Future<void> _infoCreditosActivos() async {
    try {
      final InfoCreditosActivosResponse res =
          await const CreditHttp().infoCreditosActivos();
      if (res.status == 200) {
        creditosActivos(res.infoCreditosActivos);
        status(res.status);
      } else {
        appController.manageError(res.message!);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  }

  void save(Size size) {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final AddCreditResponse res = await const CreditHttp().addCredit(
            AddCreditRequest(
              cantidadCuotas: int.parse(installmentAmount.text.trim()),
              valorCredito: General.stringToDouble(creditValue.text),
              cedulaTitularCredito: document.text.trim(),
              interesPorcentaje: double.parse(interestPercentage.text.trim()),
              fechaCredito: creditDate.text.trim(),
              fechaCuota: installmentDate.text.trim(),
              modalidad: modalidad.value
                  ? Constantes.MODALIDAD_MENSUAL.toLowerCase()
                  : Constantes.MODALIDAD_QUINCENAL.toLowerCase(),
            ),
          );
          if (res.status == 200) {
            _mostrarInfoCredito(res.data!);
            _cleanForm();
          } else {
            appController.manageError(res.message);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  Future<void> infoCreditoySaldo(int idCredito, Size size) async {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final InfoCreditoySaldoResponse res =
              await const CreditHttp().infoCreditoySaldo(idCredito);
          if (res.status == 200) {
            infoCreditoSaldo(res.infoCreditoySaldo);
            _infoCreditoSaldoModal(res.infoCreditoySaldo!, idCredito);
            nuevaFechaCuota.text = res.infoCreditoySaldo!.fechaCuota!;
          } else {
            appController.manageError(res.message!);
            nuevaFechaCuota.text = res.infoCreditoySaldo!.fechaCuota!;
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  Future<void> pagarInteresOCapital(
    Size size,
    String tipoAbono,
    String estadoCredito,
    int idCuota, [
    double? valorInteres,
  ]) async {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final GenericoResponse respuestaHttp =
              await const CreditHttp().pagarCuota(
            PagarCuotaRequest(
              valorInteres: valorInteres,
              abonoExtra: true,
              estadoCredito: estadoCredito,
              tipoAbono: tipoAbono,
              fechaAbono: General.formatoFecha(DateTime.now()),
              valorAbonado: valorAbonar,
              idCuotaCredito: idCuota,
            ),
          );
          if (respuestaHttp.status == 200) {
            _showInfoDialog(respuestaHttp.dataAbono!);
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

  Future<void> modificarFechaCuota(
    Size size,
    int idCredito,
  ) async {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final PayFeeResponse respuestaHttp = await const CreditHttp()
              .modificarFechaCuota(nuevaFechaCuota.text.trim(), idCredito);
          if (respuestaHttp.status == 200) {
            _mostrarInfoCuotaModificada(respuestaHttp.payFee!);
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

  void _showInfoDialog(DataAbono dataAbono) {
    Get.dialog(
      DialogCuotaPagada(
        dataAbono: dataAbono,
      ),
    );
  }

  ///modal que muestra informacion del credito cuando se crea
  void _mostrarInfoCredito(DataCreditResponse info) {
    Get.dialog(
      DialogInfoCredito(
        title: Constantes.INFORMACION_CREDITO,
        info: info,
      ),
    );
  }

  /// modal que muestra la informacion del credito, saldo y si quiere abonar a capital
  void _infoCreditoSaldoModal(InfoCreditoySaldo info, int idCredito) {
    Get.dialog(
      barrierDismissible: false,
      InfoCreditoSaldoModal(
        info: info,
        idCredito: idCredito,
        accion: () {},
      ),
    );
  }

  void _mostrarInfoCuotaModificada(PayFee data) {
    Get.dialog(
      DialogResponseGeneral(
        data: data,
      ),
    );
  }

  void _cleanForm() {
    document.clear();
    creditValue.clear();
    installmentAmount.clear();
    interestPercentage.clear();
    installmentDate.clear();
  }

  bool validateForm() => formKey.currentState!.validate();

  bool validarFormAbonoCapital() =>
      formKeyAbonoCapital.currentState!.validate();

  String validarEstadoCredito() {
    if (infoCreditoSaldo.value.saldoCredito! <= valorAbonar) {
      return 'C';
    } else {
      return 'A';
    }
  }

  ///inicializa fecha credito
  void _fechaInicialCredito() {
    creditDate.text = General.formatoFecha(DateTime.now());
    nuevaFechaCuota.text = General.formatoFecha(DateTime.now());
  }

  ///muestra modal de calentario
  Future<void> showCalendar(
    BuildContext context,
    TextEditingController controllerField, [
    DateTime? initialDate,
    DateTime? firstDate,
  ]) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2023),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      controllerField.text = General.formatoFecha(pickedDate);
    }
  }

  void buscarCredito(String value) {
    List<InfoCreditosActivos> results = [];
    if (value.isEmpty) {
      results = creditosActivos.value;
    } else {
      results = creditosActivos.value
          .where(
            (element) =>
                element.nombres!.toLowerCase().contains(value.toLowerCase()) ||
                element.apellidos!.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    }
    filtroCreditos.value = results;
  }

  ///carga la cedula de cliente cuando viene desde el modulo de clientes
  void _cedulaCliente() {
    document.text = Get.parameters['cedula'] ?? '';
  }

  /// cambia la modalidad
  bool? cambiarModalidad(bool value) {
    return modalidad.value = value;
  }

  double get valorAbonar => double.parse(abonar.value.text.replaceAll(",", ""));
}
