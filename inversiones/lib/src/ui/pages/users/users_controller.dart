import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/ui/pages/roles/roles_controller.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final RolesController rolesController = Get.put(RolesController());
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();
  List<MultiSelectItem<Roles>> items = [];

  @override
  Future<void> onInit() async {
    await rolesController.consultarRoles();
    items = rolesController.roles.value
        .map((roles) => MultiSelectItem<Roles>(roles, roles.name))
        .toList();
    super.onInit();
  }
}
