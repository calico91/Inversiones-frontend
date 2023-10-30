import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';

import 'package:inversiones/src/ui/pages/home/home_controller.dart';

class PayFeeController extends GetxController {
  PayFeeController(this.appController, this.homeController);

  final AppController appController;
  final HomeController homeController;

  @override
  void onInit() {
    imprimir();
    super.onInit();
  }

  void imprimir() {
    print(homeController.idCliente);
  }
/*   Future<void> loadPayFee() async {
    try {
      final PayFeeResponse clientsPendingInstallments =
          await const CreditHttp().infoPayFee(1);
      if (homeController.status == 200) {
        _status(clientsPendingInstallments.status);
        _clients(clientsPendingInstallments.clientsPendingInstallments);
      } else {
        appController.manageError(clientsPendingInstallments.message);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  } */
}
