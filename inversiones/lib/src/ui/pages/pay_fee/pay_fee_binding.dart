import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';

class PayFeeBinding implements Bindings {
  const PayFeeBinding();

  @override
  void dependencies() {
    Get.lazyPut<PayFeeController>(
      () => PayFeeController(
        Get.find<AppController>(),
        Get.find<HomeController>(),
      ),
    );
  }
}
