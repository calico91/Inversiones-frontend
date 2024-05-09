import 'dart:async';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';

class SplashController extends GetxController {
  SplashController();

  final AppController appController = Get.find<AppController>();

  final RxBool _loading = true.obs;
  final Rx<String> ruta = ''.obs;

  @override
  Future<void> onInit() async {
    Future.delayed(const Duration(seconds: 4), () => redireccionarRuta());
    super.onInit();
  }

  Future<void> redireccionarRuta() async {
    final String? token = await const SecureStorageLocal().jwtToken;
    if (token == null) {
      Get.offNamed(RouteNames.signIn);
    } else {
      Get.offNamed(RouteNames.navigationBar);
    }
  }

  bool get loading => _loading.value;
}
