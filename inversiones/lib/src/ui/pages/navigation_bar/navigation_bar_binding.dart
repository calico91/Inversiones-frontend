import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/navigation_bar/navigation_bar_controller.dart';

class NavigationBarBinding implements Bindings {
  const NavigationBarBinding();

  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(
      () => NavigationBarController(),
    );
  }
}
