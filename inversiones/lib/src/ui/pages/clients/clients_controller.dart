import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/clientes/add_client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';

class ClientsController extends GetxController {
  ClientsController(this.appController);

  final AppController appController;

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController observations = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<int> idClient = RxInt(0);
  final Rx<List<Client>> clients = Rx<List<Client>>([]);
  Rx<List<Client>> filtroClientes = Rx<List<Client>>([]);
  final Rx<int> status = Rx<int>(0);

  @override
  Future<void> onInit() async {
    await _allClients();
    await const SecureStorageLocal().saveListaClientes(clients.value);
    filtroClientes(clients.value);
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _allClients();
    filtroClientes(clients.value);
    super.onInit();
  }

  Future<void> _allClients() async {
    try {
      final AllClientsResponse res = await const ClientHttp().allClients();
      if (res.status == 200) {
        clients(res.clients);
        status(res.status);
      } else {
        appController.manageError(res.message);
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
        final List<Client> listaClienteLocal =
            await const SecureStorageLocal().listaClientes;

        try {
          final AddClientResponse respuestaHTTP =
              await const ClientHttp().addClient(
            Client(
              observaciones: observations.text.trim(),
              direccion: address.text.trim(),
              nombres: name.text.trim(),
              apellidos: lastname.text.trim(),
              celular: phoneNumber.text.trim(),
              cedula: document.text.trim(),
            ),
          );
          if (respuestaHTTP.status == 200) {
            filtroClientes.value.insert(0, respuestaHTTP.client!);

            ///al crearse un cliente se adiciona a la lista local
            listaClienteLocal.insert(0, respuestaHTTP.client!);
            await const SecureStorageLocal()
                .saveListaClientes(listaClienteLocal);

            Get.showSnackbar(
              const InfoSnackbar('cliente creado correctamente'),
            );
            _cleanForm();
          } else {
            appController.manageError(respuestaHTTP.message);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }

  void loadClient(String document, Size size) {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final AddClientResponse res =
              await const ClientHttp().loadClient(document);
          if (res.status == 200) {
            _loadClientForm(res.client!);
            idClient(res.client!.id);
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

  void updateClient(Size size) {
    Get.showOverlay(
      loadingWidget: Loading(
        vertical: size.height * 0.46,
      ),
      asyncFunction: () async {
        try {
          final AddClientResponse res = await const ClientHttp().updateClient(
            idClient.value,
            Client(
              nombres: name.text,
              apellidos: lastname.text,
              celular: phoneNumber.text.trim(),
              cedula: document.text.trim(),
              direccion: address.text,
              observaciones: observations.text,
            ),
          );
          if (res.status == 200) {
            Get.showSnackbar(
              const InfoSnackbar('cliente actualizado correctamente'),
            );
            _cleanForm();
            idClient(0);
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

  void _cleanForm() {
    document.clear();
    lastname.clear();
    name.clear();
    phoneNumber.clear();
    observations.clear();
    address.clear();
  }

  void _loadClientForm(Client client) {
    document.text = client.cedula;
    lastname.text = client.apellidos;
    name.text = client.nombres;
    address.text = client.direccion;
    observations.text = client.observaciones ?? '';
    phoneNumber.text = client.celular;
  }

  void buscarCliente(String value) {
    List<Client> results = [];
    if (value.isEmpty) {
      results = clients.value;
    } else {
      results = clients.value
          .where(
            (element) =>
                element.nombres.toLowerCase().contains(value.toLowerCase()) ||
                element.apellidos.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    }
    filtroClientes.value = results;
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
