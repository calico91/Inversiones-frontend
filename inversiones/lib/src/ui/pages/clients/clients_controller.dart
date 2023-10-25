import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/client_http.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/add_client_response.dart';
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
  final GlobalKey<FormState> formKeyDocument = GlobalKey<FormState>();
  final Rx<int> _idClient = RxInt(0);

  void save() {
    Get.showOverlay(
      loadingWidget: const Loading(),
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

  void loadClient() {
    Get.showOverlay(
      loadingWidget: const Loading(),
      asyncFunction: () async {
        try {
          final AddClientResponse res =
              await const ClientHttp().loadClient(document.text.trim());
          if (res.status == 200) {
            _loadClientForm(res.client!);
            _idClient(res.client!.id);
          } else {
            appController.manageError(res.message);
          }
        } on HttpException catch (e) {
          print('+++');
          appController.manageError(e.message);
        } catch (e) {
          print('5555');

          appController.manageError(e.toString());
        }
      },
    );
  }

  void updateClient() {
    Get.showOverlay(
      loadingWidget: const Loading(),
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
    lastname.text = client.apellidos;
    name.text = client.nombres;
    address.text = client.direccion;
    observations.text = client.observaciones ?? '';
    phoneNumber.text = client.celular;
  }

  bool validateForm() {
    return formKeyDocument.currentState!.validate() &&
        formKey.currentState!.validate();
  }

  bool validateFormDocument() {
    return formKeyDocument.currentState!.validate();
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  int get idClient => _idClient.value;
}
