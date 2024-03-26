import 'package:get/get.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/error_snackbar.dart';

class AppController extends GetxController {
  Future<void> manageError(String error) async {
    if (error == 'security-token-required' ||
        error == 'invalid-token' ||
        error == 'Token caduco, inicie sesion de nuevo') {
      Get.offAllNamed(RouteNames.signIn);
      await const SecureStorageLocal().saveToken(null);

      Get.showSnackbar(ErrorSnackbar(error));
    } else {
      Get.showSnackbar(ErrorSnackbar(error));
    }
  }
}
