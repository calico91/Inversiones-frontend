import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';

class UserController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> formKeyUsuario = GlobalKey<FormState>();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController rol = TextEditingController();
}
