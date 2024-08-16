import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/user_http.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/ui/pages/roles/roles_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final RolesController rolesController = Get.put(RolesController());
  RxBool cargando = true.obs;
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();

  Rx<List<MultiSelectItem<Roles>>> items = Rx([]);
  Rx<List<Roles>> rolesAsignados = Rx([]);

  @override
  Future<void> onInit() async {
    await rolesController.consultarRoles();
    await consultarUsuarios();
    items.value = rolesController.roles.value
        .map((roles) => MultiSelectItem<Roles>(roles, roles.name))
        .toList();
    super.onInit();
  }

  void registrarUsuario() {
    if (General.validateForm(formKeyUsuario)) {
      if (rolesAsignados.value.isEmpty) {
        appController.manageError('Seleccione los roles que desea asignar');
      } else {
        Get.showOverlay(
            loadingWidget: CargandoAnimacion(),
            asyncFunction: () async {
              try {
                await const UserHttp().registrarUsuario(User(
                    username: nombreUsuario.text.trim(),
                    firstname: nombres.text.trim(),
                    lastname: apellidos.text.trim(),
                    email: correo.text.trim(),
                    roles: rolesAsignados.value));

                _clearForm();
                Get.showSnackbar(
                    const InfoSnackbar('cliente creado correctamente'));
                await rolesController.consultarRoles();
              } on HttpException catch (e) {
                appController.manageError(e.message);
              } catch (e) {
                appController.manageError(e.toString());
              }
            });
      }
    }
  }

  Future<void> consultarUsuarios() async {
    try {
      cargando(true);
      final ApiResponse<List<User>> usuarios =
          await const UserHttp().consultarUsuarios();
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    } finally {
      cargando(false);
    }
  }

  void _clearForm() {
    nombres.clear();
    apellidos.clear();
    nombreUsuario.clear();
    correo.clear();
    rol.clear();
    Get.focusScope!.unfocus();
  }
}
