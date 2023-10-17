import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';

class HomeController extends GetxController {
  HomeController(this.appController);

  final AppController appController;

  final UserDetails userDetails = Get.arguments as UserDetails;
}
