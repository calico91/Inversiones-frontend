import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/ui/pages/clients/clients_page.dart';
import 'package:inversiones/src/ui/pages/credits/credits_page.dart';
import 'package:inversiones/src/ui/pages/home/home_page.dart';

class NavigationBarController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final Rx<int> indexPage = 0.obs;
  final screens = [const HomePage(), const ClientsPage(), const CreditsPage()];
}
