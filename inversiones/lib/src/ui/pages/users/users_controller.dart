import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/user_http.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/ui/pages/permisos/permisos_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final RolesController rolesController = Get.put(RolesController());
  RxBool cargando = true.obs;
  RxBool registrar = true.obs;
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();
  final TextEditingController buscarUsuarioCtrl = TextEditingController();
  int idUsuarioSeleccionado = 0;

  Rx<List<MultiSelectItem<Roles>>> items = Rx([]);
  Rx<List<Roles>> rolesAsignados = Rx([]);
  Rx<List<User>> usuarios = Rx([]);
  Rx<List<User>> filtroUsuarios = Rx<List<User>>([]);

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
            loadingWidget: const CargandoAnimacion(),
            asyncFunction: () async {
              try {
                final ApiResponse<User> respuestaHttp = await const UserHttp()
                    .registrarUsuario(User(
                        username: nombreUsuario.text.trim(),
                        firstname: nombres.text.trim(),
                        lastname: apellidos.text.trim(),
                        email: correo.text.trim(),
                        roles: rolesAsignados.value));

                _clearForm();
                Get.showSnackbar(
                    const InfoSnackbar('Usuario creado correctamente'));
                filtroUsuarios.value.add(respuestaHttp.data!);
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
      final ApiResponse<List<User>> respuestaHttp =
          await const UserHttp().consultarUsuarios();

      usuarios(respuestaHttp.data);
      filtroUsuarios(respuestaHttp.data);
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    } finally {
      cargando(false);
    }
  }

  void consultarUsuario(int id) {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final ApiResponse<User> respuestaHttp =
                await const UserHttp().consultarUsuario(id);
            _asignarValoresFormulario(respuestaHttp.data!);
            idUsuarioSeleccionado = id;
            registrar(false);
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void actualizarUsuario() {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            await const UserHttp().actualizarUsuario(User(
                id: idUsuarioSeleccionado,
                username: nombreUsuario.text.trim(),
                firstname: nombres.text.trim(),
                lastname: apellidos.text.trim(),
                email: correo.text.trim(),
                roles: rolesAsignados.value));

            _clearForm();
            Get.showSnackbar(
                const InfoSnackbar('Usuario actualizado correctamente'));
            registrar(true);
            await consultarUsuarios();
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void cambiarEstadoUsuario(int id) {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final ApiResponse<String> respuestaHttp =
                await const UserHttp().cambiarEstado(id);

            _clearForm();
            Get.showSnackbar(InfoSnackbar(respuestaHttp.data!));
            registrar(true);
            await consultarUsuarios();
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void reinicarContrasena(int id) {
    Get.showOverlay(
        loadingWidget: const CargandoAnimacion(),
        asyncFunction: () async {
          try {
            final ApiResponse<String> respuestaHttp =
                await const UserHttp().reinicarContrasena(id);

            _clearForm();
            Get.showSnackbar(InfoSnackbar(respuestaHttp.data!));
            registrar(true);
            await consultarUsuarios();
          } on HttpException catch (e) {
            appController.manageError(e.message);
          } catch (e) {
            appController.manageError(e.toString());
          }
        });
  }

  void _clearForm() {
    formKeyUsuario.currentState?.reset();
    nombres.clear();
    apellidos.clear();
    nombreUsuario.clear();
    correo.clear();
    rol.clear();
    rolesAsignados.value = [];
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void buscarUsuario(String value, bool focus) {
    List<User> results = [];
    if (value.isEmpty || !focus) {
      results = usuarios.value;
      buscarUsuarioCtrl.clear();
    } else {
      results = usuarios.value
          .where((element) =>
              element.firstname!.toLowerCase().contains(value.toLowerCase()) ||
              element.lastname!.toLowerCase().contains(value.toLowerCase()) ||
              element.username!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    filtroUsuarios.value = results;
  }

  void _asignarValoresFormulario(User user) {
    nombres.text = user.firstname!;
    apellidos.text = user.lastname!;
    nombreUsuario.text = user.username!;
    correo.text = user.email!;
    rolesAsignados.value = user.roles!;
  }
}
