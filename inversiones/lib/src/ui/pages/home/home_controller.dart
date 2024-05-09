import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/data/http/src/userdetails_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';

class HomeController extends GetxService {
  final AppController appController = Get.find<AppController>();
  final RxBool _loading = false.obs;
  final Rx<List<ClientsPendingInstallment>> _clients =
      Rx<List<ClientsPendingInstallment>>([]);
  final Rx<int> _status = 0.obs;
  final Rx<int> idCliente = 0.obs;
  final Rx<int> idCredito = 0.obs;
  final Rx<String> nombreCliente = ''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final Rx<UserDetails> userDetails = UserDetails().obs;
  final Rx<int> indexPage = 0.obs;

  final TextEditingController fechafiltro = TextEditingController();

  @override
  Future<void> onInit() async {
    userDetails(await const SecureStorageLocal().userDetails);
    fechafiltro.text = General.formatoFecha(DateTime.now());
    super.onInit();
  }

  Future<void> loadClientsPendingInstallments([String? fechaFiltro]) async {
    try {
      _loading(true);
      final ClientsPendingInstallmentsResponse clientsPendingInstallments =
          await const ClientHttp().clientsPendingInstallments(
              fechaFiltro ?? General.formatoFecha(DateTime.now()),
              userDetails.value.id!);
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
    } finally {
      _loading(false);
    }
  }

  Future<void> vincularDispositivo(Size size) async {
    final String? idmovil = await const SecureStorageLocal().idMovil;

    Get.showOverlay(
      loadingWidget:CargandoAnimacion(),
      asyncFunction: () async {
        try {
          await const SecureStorageLocal()
              .saveUsuarioBiometria(userDetails.value.username);

          final GenericoResponse respuestaHttp =
              await const UserDetailsHttp().vincularDispositivo(
            VincularDispositivoRequest(
                username: userDetails.value.username!,
                idDispositivo: idmovil ?? ""),
          );
          if (respuestaHttp.status == 200) {
            Get.showSnackbar(
              InfoSnackbar(respuestaHttp.data),
            );
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

  void limpiarCampos() {
    interestPercentage.clear();
    installmentAmount.clear();
    creditValue.clear();
  }

  bool get loading => _loading.value;

  int get status => _status.value;

  int get idClienteSeleccionado => idCliente.value;
  String get nombreClienteSeleccionado => nombreCliente.value;

  List<ClientsPendingInstallment> get clients => _clients.value;

  bool mostrarModulo(List<String> rol) =>
      userDetails.value.authorities!.any((elemento) => rol.contains(elemento));
}
