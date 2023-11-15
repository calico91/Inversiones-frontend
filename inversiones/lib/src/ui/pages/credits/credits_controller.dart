import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_creditos_activos.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/info_credito_saldo.dart';
import 'package:inversiones/src/ui/pages/home/dialog/dialog_info.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class CreditsController extends GetxController {
  CreditsController(this.appController);

  final AppController appController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAbonoCapital = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final TextEditingController abonoCapital = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController installmentDate = TextEditingController();
  final TextEditingController creditDate = TextEditingController();
  final Rx<int> status = Rx(0);
  final Rx<List<InfoCreditosActivos>> creditosActivos =
      Rx<List<InfoCreditosActivos>>([]);

  Rx<List<InfoCreditosActivos>> filtroCreditos =
      Rx<List<InfoCreditosActivos>>([]);
  Rx<InfoCreditoySaldo> infoCreditoSaldo =
      Rx<InfoCreditoySaldo>(InfoCreditoySaldo());

  @override
  Future<void> onInit() async {
    _creditDateInit();
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

  void save() {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
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
            ),
          );
          if (res.status == 200) {
            _showInfoDialog(res.data!);
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

  Future<void> infoCreditoySaldo(int idCredito) async {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
      asyncFunction: () async {
        try {
          final InfoCreditoySaldoResponse res =
              await const CreditHttp().infoCreditoySaldo(idCredito);
          if (res.status == 200) {
            infoCreditoSaldo(res.infoCreditoySaldo);
            _infoCreditoSaldoModal(res.infoCreditoySaldo!);
          } else {
            appController.manageError(res.message!);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  ///modal que muestra informacion del credito cuando se crea
  void _showInfoDialog(DataCreditResponse info) {
    Get.dialog(
      DialogInfo(
        title: 'Informacion credito',
        info: info,
      ),
    );
  }

  /// modal que muestra la informacion del credito, saldo y si quiere abonar a capital
  void _infoCreditoSaldoModal(InfoCreditoySaldo info) {
    Get.dialog(
      InfoCreditoSaldoModal(
        title: 'Informacion credito',
        info: info,
        accion: () {},
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
    if (infoCreditoSaldo.value.saldoCredito == abonoCapital.value) {
      return 'C';
    } else {
      return 'A';
    }
  }

  ///inicializa fecha credito
  void _creditDateInit() {
    creditDate.text = _formattedDate(DateTime.now());
  }

  ///muestra modal de calentario
  Future<void> showCalendar(
    BuildContext context,
    TextEditingController controllerField,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      controllerField.text = _formattedDate(pickedDate);
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

  ///formatea fecha
  String _formattedDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
