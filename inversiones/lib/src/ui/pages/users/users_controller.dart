import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/user_http.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/ui/pages/roles/roles_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final RolesController rolesController = Get.put(RolesController());
  RxBool cargando = false.obs;
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();
  List<MultiSelectItem<Roles>> items = [];
  List<Roles> rolesAsignados = [];

  @override
  Future<void> onInit() async {
    await rolesController.consultarRoles();
    items = rolesController.roles.value
        .map((roles) => MultiSelectItem<Roles>(roles, roles.name))
        .toList();
    super.onInit();
  }

  void registrarUsuario() {
    if (General.validateForm(formKeyUsuario)) {
      if (rolesAsignados.isEmpty) {
        appController.manageError('Seleccione los roles que desea asignar');
      } else {

        print(rolesAsignados.toString());
        Get.showOverlay(
            loadingWidget: CargandoAnimacion(),
            asyncFunction: () async {
              try {
                User user = User(
                    username: nombreUsuario.text.trim(),
                    firstname: nombres.text.trim(),
                    lastname: apellidos.text.trim(),
                    email: correo.text.trim(),
                    roles: rolesAsignados);

                print(user.toJson());
                await const UserHttp().registrarUsuario(user);

                Get.showSnackbar(
                    const InfoSnackbar('cliente creado correctamente'));
              } on HttpException catch (e) {
                appController.manageError(e.message);
              } catch (e) {
                appController.manageError(e.toString());
              }
            });
      }
    }
  }
}
