import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class HomeController extends GetxService {
  HomeController(this.appController);

  final AppController appController;
  final RxBool _loading = RxBool(false);
  final Rx<List<ClientsPendingInstallment>> _clients =
      Rx<List<ClientsPendingInstallment>>([]);
  final Rx<int> _status = Rx<int>(0);
  final Rx<int> idCliente = Rx<int>(0);
  final Rx<int> idCredito = Rx<int>(0);
  final Rx<String> nombreCliente = Rx<String>('');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final Rx<UserDetails> userDetails = Rx<UserDetails>(const UserDetails());

  @override
  Future<void> onInit() async {
    userDetails(await const SecureStorageLocal().userDetails);
    loadClientsPendingInstallments();
    super.onInit();
  }

  Future<void> loadClientsPendingInstallments() async {
    try {
      final ClientsPendingInstallmentsResponse clientsPendingInstallments =
          await const ClientHttp().clientsPendingInstallments();
      if (clientsPendingInstallments.status == 200) {
        _status(clientsPendingInstallments.status);
        _clients(clientsPendingInstallments.clientsPendingInstallments);
      } else {
        appController.manageError(clientsPendingInstallments.message);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  }

  void logout() {
    Get.showOverlay(
      loadingWidget: const Loading(),
      asyncFunction: () async {
        await const SecureStorageLocal().saveToken(null);
        Get.offAllNamed(RouteNames.signIn);
      },
    );
  }

  /// calcula el valor de la cuota a pagar
  String calculateCreditFee() {
    final double interest = General.stringToDouble(creditValue.text) *
        (double.parse(interestPercentage.text) / 100);

    final double creditFee = General.stringToDouble(creditValue.text) /
            double.parse(installmentAmount.text) +
        interest;

    return General.formatoMoneda(creditFee);
  }

  bool get loading => _loading.value;

  int get status => _status.value;

  int get idClienteSeleccionado => idCliente.value;
  String get nombreClienteSeleccionado => nombreCliente.value;

  List<ClientsPendingInstallment> get clients => _clients.value;
}
