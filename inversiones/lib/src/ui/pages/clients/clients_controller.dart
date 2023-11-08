import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
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
  final Rx<int> _idClient = RxInt(0);
  final Rx<List<Client>> _clients = Rx<List<Client>>([]);
  final Rx<int> _status = Rx<int>(0);

  @override
  void onInit() {
    _allClients();
    super.onInit();
  }

  Future<void> _allClients() async {
    try {
      final AllClientsResponse res = await const ClientHttp().allClients();
      if (res.status == 200) {
        _clients(res.clients);
        _status(res.status);
      } else {
        appController.manageError(res.message);
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
          final AddClientResponse res = await const ClientHttp().addClient(
            Client(
              observaciones: observations.text.trim(),
              direccion: address.text.trim(),
              nombres: name.text.trim(),
              apellidos: lastname.text.trim(),
              celular: phoneNumber.text.trim(),
              cedula: document.text.trim(),
            ),
          );
          if (res.status == 200) {
            Get.showSnackbar(
              const InfoSnackbar('cliente creado correctamente'),
            );
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

  void loadClient(String document) {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
      asyncFunction: () async {
        try {
          final AddClientResponse res =
              await const ClientHttp().loadClient(document);
          if (res.status == 200) {
            _loadClientForm(res.client!);
            _idClient(res.client!.id);
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

  void updateClient() {
    Get.showOverlay(
      loadingWidget: const Loading().circularLoading(),
      asyncFunction: () async {
        try {
          final AddClientResponse res = await const ClientHttp().updateClient(
            idClient,
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
            _idClient(0);
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

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  int get idClient => _idClient.value;
  List<Client> get clients => _clients.value;
  int get status => _status.value;
}
