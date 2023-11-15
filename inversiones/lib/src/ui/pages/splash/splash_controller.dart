import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/userdetails_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/error_snackbar.dart';

class SplashController extends GetxController {
  SplashController(this.appController);
  final AppController appController;

  final RxBool _loading = RxBool(true);

  @override
  void onInit() {
    load();
    super.onInit();
  }

  Future<void> load() async {
    try {
      final String? token = await const SecureStorageLocal().jwtToken;
      if (token == null) {
        return Get.offNamed(RouteNames.signIn);
      }
      return await const UserDetailsHttp().userDetails.then((value) {
        if (value.status == 200) {
          Get.offNamed(RouteNames.home, arguments: value.userDetails);
        } else {
          appController.manageError(value.message);
          Get.offNamed(RouteNames.signIn);
        }
      });
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      Get.offNamed(RouteNames.signIn);

      Get.showSnackbar(ErrorSnackbar(e.toString()));
    } finally {
      _loading(false);
    }
  }

  bool get loading => _loading.value;
}
