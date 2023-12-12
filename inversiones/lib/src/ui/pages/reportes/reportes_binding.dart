import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';

class ReportesBinding implements Bindings {
  const ReportesBinding();

  @override
  void dependencies() {
    Get.lazyPut<ReportesController>(
      () => ReportesController(Get.find<AppController>()),
    );
  }
}
