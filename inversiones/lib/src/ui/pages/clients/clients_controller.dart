import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';

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
}
