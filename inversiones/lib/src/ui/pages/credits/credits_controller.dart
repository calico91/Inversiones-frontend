import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/data/http/src/credit_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/creditos/estado_credito_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_creditos_activos_response.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/abono_response.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_abonos_realizados.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_estado_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_info_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_lista_clientes.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_response_general.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/info_credito_saldo.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:lottie/lottie.dart';

class CreditsController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAbonoCapital = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final TextEditingController abonar = TextEditingController();
  final TextEditingController nombreCliente = TextEditingController();
  final TextEditingController installmentDate = TextEditingController();
  final TextEditingController creditDate = TextEditingController();
  final TextEditingController nuevaFechaCuota = TextEditingController();
  final Rx<int> estadoCredito = Rx(Constantes.CODIGO_CREDITO_ACTIVO);
  TextEditingController campoBuscarCredito = TextEditingController();
  TextEditingController campoBuscarCliente = TextEditingController();
  final Rx<int> status = Rx(0);
  final Rx<List<InfoCreditosActivos>> creditosActivos =
      Rx<List<InfoCreditosActivos>>([]);

  final Rx<int> idCuotaSeleccionada = Rx(0);
  final Rx<bool> modalidad = Rx<bool>(true);

  Rx<List<InfoCreditosActivos>> filtroCreditos =
      Rx<List<InfoCreditosActivos>>([]);

  Rx<InfoCreditoySaldo> infoCreditoSaldo =
      Rx<InfoCreditoySaldo>(InfoCreditoySaldo());

  final Rx<List<Client>> listaClientes = Rx<List<Client>>([]);
  Rx<List<Client>> filtroClientes = Rx<List<Client>>([]);
  final Rx<String> cedulaClienteSeleccionado = Rx<String>("");
  @override
  void onInit() {
    _fechaInicialCredito();
    _datosCliente();
    super.onInit();
  }

  Future<void> infoCreditosActivos() async {
    Get.showOverlay(
        loadingWidget: Lottie.asset(Constantes.CARGANDO),
        asyncFunction: () async {
          try {
            final InfoCreditosActivosResponse res =
                await const CreditHttp().infoCreditosActivos();
            if (res.status == 200) {
              creditosActivos(res.infoCreditosActivos);
              filtroCreditos(creditosActivos.value);
            } else {
              appController.manageError(res.message!);
            }
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void save() {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final UserDetails? userDetails =
              await const SecureStorageLocal().userDetails;
          final AddCreditResponse res = await const CreditHttp().addCredit(
            AddCreditRequest(
                cantidadCuotas: int.parse(installmentAmount.text.trim()),
                valorCredito: General.stringToDouble(creditValue.text),
                cedulaTitularCredito: cedulaClienteSeleccionado.value,
                interesPorcentaje: double.parse(interestPercentage.text.trim()),
                fechaCredito: creditDate.text.trim(),
                fechaCuota: installmentDate.text.trim(),
                modalidad: modalidad.value
                    ? Modalidad(id: Constantes.CODIGO_MODALIDAD_MENSUAL)
                    : Modalidad(id: Constantes.CODIGO_MODALIDAD_QUINCENAL),
                usuario: userDetails?.username ?? ""),
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

  ///modal que muestra informacion del credito cuando se crea
  void _mostrarInfoCredito(DataCreditResponse info) {
    Get.dialog(
      DialogInfoCredito(
        title: Constantes.INFORMACION_CREDITO,
        info: info,
      ),
    );
  }

  Future<void> infoCreditoySaldo(int idCredito) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
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

  Future<void> pagarInteresOCapital(
    String tipoAbono,
    String estadoCredito,
    int idCuota, [
    double? valorInteres,
  ]) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final AbonoResponse respuestaHttp =
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
            General.mostrarModalCompartirAbonos(respuestaHttp.dataAbono!, false,
                homeController.nombreClienteSeleccionado);
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

  Future<void> modificarFechaCuota(int idCredito, BuildContext context) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final PayFeeResponse respuestaHttp = await const CreditHttp()
              .modificarFechaCuota(nuevaFechaCuota.text.trim(), idCredito);
          if (respuestaHttp.status == 200) {
            if (context.mounted) Navigator.pop(context);
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

  /// info de la cuota cuando se modifica la fecha de pago
  void _mostrarInfoCuotaModificada(PayFee data) {
    Get.dialog(
      DialogResponseGeneral(
        data: data,
      ),
    );
  }

  Future<void> modificarEstadoCredito(
      int idCredito, int estadoCredito, BuildContext context) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final EstadoCreditoResponse respuestaHttp = await const CreditHttp()
              .modificarEstadoCredito(idCredito, estadoCredito);
          if (respuestaHttp.status == 200) {
            if (context.mounted) Navigator.pop(context);
            _mostrarInformacionEstadoCredito(respuestaHttp.estadoCredito!);
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

  void _mostrarInformacionEstadoCredito(String info) {
    Get.dialog(
      barrierDismissible: false,
      DialogEstadoCredito(
        info: info,
      ),
    );
  }

  Future<void> consultarAbonosRealizados(int idCredito) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final AbonosRealizadosResponse res =
              await const CreditHttp().consultarAbonosRealizados(idCredito);
          if (res.status == 200) {
            _mostrarAbonosRealizados(res.abonosRealizados!);
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

  /// informacion abonos realizados
  void _mostrarAbonosRealizados(List<AbonosRealizados> abonosRealizados) {
    Get.dialog(
      DialogAbonosRealizados(
        abonosRealizados: abonosRealizados,
      ),
    );
  }

  Future<void> consultarAbonoPorId(int idCuotaCredito) async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        try {
          final AbonoResponse res =
              await const CreditHttp().consultarAbonoPorId(idCuotaCredito);
          if (res.status == 200) {
            General.mostrarModalCompartirAbonos(
                res.dataAbono!, true, homeController.nombreClienteSeleccionado);
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

  Future<void> consultarClientes() async {
    Get.showOverlay(
      loadingWidget: Lottie.asset(Constantes.CARGANDO),
      asyncFunction: () async {
        /// si la lista ya se cargo una vez, se guarda en local storage y no se consulta de nuevo
        final List<Client> listaClienteLocal =
            await const SecureStorageLocal().listaClientes;
        if (listaClienteLocal.isNotEmpty) {
          _asignarListaClientes(listaClienteLocal);
          return;
        }

        try {
          final AllClientsResponse respuestaHTTP =
              await const ClientHttp().allClients();

          _asignarListaClientes(respuestaHTTP.clients!);
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  ///Asigna los valores de la consulta HTTP o del cache si esta guardado de la lista de clientes
  Future<void> _asignarListaClientes(List<Client> getLista) async {
    await const SecureStorageLocal().saveListaClientes(getLista);
    listaClientes(getLista);
    filtroClientes(getLista);
    _mostrarListaClientes(getLista);
  }

  void _mostrarListaClientes(List<Client> clientes) {
    Get.dialog(
      DialogListaClientes(),
    );
  }

  void _cleanForm() {
    nombreCliente.clear();
    creditValue.clear();
    installmentAmount.clear();
    interestPercentage.clear();
    installmentDate.clear();
  }

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

  /// busca los clientes en la lista de creditos y en la lista de clientes
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
  void _datosCliente() {
    nombreCliente.text = Get.parameters['nombreCliente'] ?? '';
    cedulaClienteSeleccionado.value = Get.parameters['cedula'] ?? '';
  }

  /// cambia la modalidad
  bool? cambiarModalidad(bool value) {
    return modalidad.value = value;
  }

  double get valorAbonar => double.parse(abonar.value.text.replaceAll(",", ""));
}
