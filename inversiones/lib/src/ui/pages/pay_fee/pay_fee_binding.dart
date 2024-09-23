import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';

class PayFeeBinding implements Bindings {
  const PayFeeBinding();

  @override
  void dependencies() {
    Get.lazyPut<PayFeeController>(() => PayFeeController());
  }
}
