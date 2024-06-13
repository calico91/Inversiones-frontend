import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_info_credito_creado.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/dialog_lista_clientes.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/informacion_credito/dialog_abonos_realizados.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/informacion_credito/dialog_estado_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/informacion_credito/dialog_fecha_cuota_modificada.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/informacion_credito/info_credito_saldo.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/text_editing_reactivos.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';

class CreditsController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formRenovacion = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAbonoCapital = GlobalKey<FormState>();
  final TextEditingController valorCredito = TextEditingController();
  final TextEditingController cantidadCuotas = TextEditingController();
  final TextEditingController porcentajeInteres = TextEditingController();
  final TextEditingController abonar = TextEditingController();
  final TextEditingController nombreCliente = TextEditingController();
  final TextEditingController fechaCuota = TextEditingController();
  final TextEditingController fechaCredito = TextEditingController();
  final TextEditingController nuevaFechaCuota = TextEditingController();
  final Rx<int> estadoCredito = Rx(Constantes.CODIGO_CREDITO_ACTIVO);
  TextEditingController campoBuscarCredito = TextEditingController();
  TextEditingController campoBuscarCliente = TextEditingController();
  final Rx<int> status = 0.obs;
  final Rx<List<InfoCreditosActivos>> creditosActivos =
      Rx<List<InfoCreditosActivos>>([]);

  final Rx<int> idCuotaSeleccionada = 0.obs;
  final Rx<bool> modalidad = true.obs;

  Rx<List<InfoCreditosActivos>> filtroCreditos =
      Rx<List<InfoCreditosActivos>>([]);

  Rx<InfoCreditoySaldo> infoCreditoSaldo =
      Rx<InfoCreditoySaldo>(InfoCreditoySaldo());

  final Rx<List<Client>> listaClientes = Rx<List<Client>>([]);
  Rx<List<Client>> filtroClientes = Rx<List<Client>>([]);
  final ReactiveTextEditingController valorCreditoRenovacion =
      ReactiveTextEditingController();
  final ReactiveTextEditingController valorAEntregar =
      ReactiveTextEditingController();

  RxString valorEntregarResultado = '0.0'.obs;
  Rx<double> valorCreditoRX = 0.0.obs;

  String? nombreClienteSeleccionado;
  int? idClienteSeleccionado;
  double? saldoCreditoSeleccionado;

  int? idCreditoSeleccionado;
  @override
  void onInit() {
    valorCreditoRenovacion.text.listen((_) => _calcularRenovacion());
    _fechaInicialCredito();
    super.onInit();
  }

  Future<void> infoCreditosActivos() async {
    Get.showOverlay(
        loadingWidget: CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final InfoCreditosActivosResponse res =
                await const CreditHttp().infoCreditosActivos();
            if (res.status == 200) {
              campoBuscarCredito.clear();
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

  void save(bool renovarCredito) {
    Get.showOverlay(
      loadingWidget: CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final UserDetails? userDetails =
              await const SecureStorageLocal().userDetails;

          final AddCreditResponse res = await const CreditHttp().addCredit(
              AddCreditRequest(
                  cantidadCuotas: int.parse(cantidadCuotas.text.trim()),
                  valorCredito: !renovarCredito
                      ? General.stringToDouble(valorCredito.text)
                      : General.stringToDouble(
                          valorCreditoRenovacion.text.value),
                  interesPorcentaje:
                      double.parse(porcentajeInteres.text.trim()),
                  fechaCredito: fechaCredito.text.trim(),
                  fechaCuota: fechaCuota.text.trim(),
                  modalidad: modalidad.value
                      ? Modalidad(id: Constantes.CODIGO_MODALIDAD_MENSUAL)
                      : Modalidad(id: Constantes.CODIGO_MODALIDAD_QUINCENAL),
                  usuario: userDetails?.username ?? "",
                  idCliente: idClienteSeleccionado,
                  idCreditoActual: idCreditoSeleccionado,
                  renovacion: renovarCredito,
                  valorRenovacion:
                      General.stringToDouble(valorEntregarResultado.value)));

          _mostrarInfoCreditoCreado(res.data!, renovarCredito);
          _limpiarFormularioCredito();
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  ///modal que muestra informacion del credito cuando se crea
  void _mostrarInfoCreditoCreado(DataCreditResponse info, bool renovarCredito) {
    Get.dialog(DialogInfoCreditoCreado(
        title: Constantes.INFORMACION_CREDITO,
        info: info,
        renovarCredito: renovarCredito));
  }

  Future<void> infoCreditoySaldo(int idCredito) async {
    idCreditoSeleccionado = idCredito;
    Get.showOverlay(
      loadingWidget: CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final InfoCreditoySaldoResponse res =
              await const CreditHttp().infoCreditoySaldo(idCredito);
          if (res.status == 200) {
            infoCreditoSaldo(res.infoCreditoySaldo);
            _infoCreditoSaldoModal(res.infoCreditoySaldo!, idCredito);
            nuevaFechaCuota.text = res.infoCreditoySaldo!.fechaCuota!;
            saldoCreditoSeleccionado = res.infoCreditoySaldo!.saldoCredito;
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
      loadingWidget: CargandoAnimacion(),
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
      loadingWidget: CargandoAnimacion(),
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
      DialogFechaCuotaModificada(
        data: data,
      ),
    );
  }

  Future<void> modificarEstadoCredito(
      int idCredito, int estadoCredito, BuildContext context) async {
    Get.showOverlay(
      loadingWidget: CargandoAnimacion(),
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
    idCreditoSeleccionado = idCredito;
    Get.showOverlay(
      loadingWidget: CargandoAnimacion(),
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
      loadingWidget: CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final AbonoResponse res =
              await const CreditHttp().consultarAbonoPorId(idCuotaCredito);
          General.mostrarModalCompartirAbonos(
              res.dataAbono!,
              true,
              homeController.nombreClienteSeleccionado,
              true,
              idCreditoSeleccionado);
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  Future<void> anularUltimoAbono(int idAbono, int idCredito) async {
    Get.showOverlay(
      loadingWidget: CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final GenericoResponse res =
              await const CreditHttp().anularUltimoAbono(idAbono, idCredito);
          Get.back();
          Get.back();
          Get.back();
          Get.showSnackbar(InfoSnackbar(res.data));
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
      loadingWidget: CargandoAnimacion(),
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
    Get.dialog(DialogListaClientes());
  }

  void _limpiarFormularioCredito() {
    formKey.currentState!.reset();
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
    fechaCredito.text = General.formatoFecha(DateTime.now());
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

  void limpiarFormularioRenovacion() {
    formRenovacion.currentState!.reset();
    valorCreditoRX.value = 0.0;
    valorEntregarResultado.value = '0.0';
    fechaCredito.text = General.formatoFecha(DateTime.now());
    fechaCuota.clear();
    Get.back();
  }

  /// cambia la modalidad
  bool? cambiarModalidad(bool value) {
    return modalidad.value = value;
  }

  void _calcularRenovacion() {
    valorCreditoRX.value =
        General.stringToDouble(valorCreditoRenovacion.text.value);

    final double result =
        valorCreditoRX.value - (saldoCreditoSeleccionado ?? 0.0);

    valorEntregarResultado.value =
        NumberFormat('#,###', 'es_CO').format(result);
  }

  double get valorAbonar => double.parse(abonar.value.text.replaceAll(",", ""));
}
