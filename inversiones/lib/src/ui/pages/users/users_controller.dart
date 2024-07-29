import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();
  List<MultiSelectItem<Roles>> items = [];

  Rx<List<Roles>> roles = Rx<List<Roles>>([]);

  @override
  void onInit() {
    roles.value.addAll([
      const Roles(id: 2, name: 'admin'),
      const Roles(id: 3, name: 'cobrador'),
      const Roles(id: 4, name: 'generico')
    ]);

    items = roles.value
        .map((roles) => MultiSelectItem<Roles>(roles, roles.name))
        .toList();
    super.onInit();
  }
}
