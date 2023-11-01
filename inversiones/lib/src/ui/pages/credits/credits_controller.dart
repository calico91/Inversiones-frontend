import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/responses/add_credit_response.dart';
import 'package:inversiones/src/ui/pages/home/dialog/dialog_info.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class CreditsController extends GetxController {
  CreditsController(this.appController);

  final AppController appController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController installmentDate = TextEditingController();
  final TextEditingController creditDate = TextEditingController();

  @override
  void onInit() {
    _creditDateInit();
    super.onInit();
  }

  void save() {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
      asyncFunction: () async {
        try {
          final AddCreditResponse res = await const CreditHttp().addCredit(
            AddCreditRequest(
              cantidadCuotas: int.parse(installmentAmount.text.trim()),
              cantidadPrestada: General.stringToDouble(creditValue.text),
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

  void _showInfoDialog(DataCreditResponse info) {
    Get.dialog(
      DialogInfo(
        title: 'Informacion credito',
        info: info,
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

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  ///inicializa fecha credito
  void _creditDateInit() {
    creditDate.text = formattedDate(DateTime.now());
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
      controllerField.text = formattedDate(pickedDate);
    }
  }

  ///formatea fecha
  String formattedDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
