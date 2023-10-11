import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';

class AppBinding implements Bindings {
  const AppBinding();
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
  }
}
