import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inversiones/src/app_controller.dart';

class CreditsController extends GetxController {
  CreditsController(this.appController);

  final AppController appController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController creditValue = TextEditingController();
  final TextEditingController installmentAmount = TextEditingController();
  final TextEditingController interestPercentage = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController installmentDate = TextEditingController();
  final TextEditingController creditDate = TextEditingController();
}
