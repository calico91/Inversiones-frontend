import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';

class CreditsBinding implements Bindings {
  const CreditsBinding();

  @override
  void dependencies() {
    Get.lazyPut<CreditsController>(
      () => CreditsController(Get.find<AppController>()),
    );
  }
}
