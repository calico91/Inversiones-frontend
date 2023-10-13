import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/error_snackbar.dart';

class AppController extends GetxController {
  void manageError(String error) {
    if (error == 'security-token-required' ||
        error == 'invalid-token' ||
        error == 'token-has-expired' ||
        error == 'Your credentials are incorrect') {
      Get.offAllNamed(RouteNames.signIn);
      Get.showSnackbar(ErrorSnackbar(error));
    } else {
      Get.showSnackbar(ErrorSnackbar(error));
    }
  }
}
