import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/sing_in_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/sing_in_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class SignInController extends GetxController {
  SignInController(this.appController);

  final AppController appController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<bool> obscureText = Rx<bool>(true);

  void signIn(Size size) {
    if (formKey.currentState!.validate()) {
      Get.showOverlay(
        asyncFunction: () async {
          try {
            final SignInResponse res =
                await const SignInHttp().signInWithUsernameAndPassword(
              usernameController.text.trim(),
              passwordController.value.text,
            );
            if (res.status == 200) {
              await const SecureStorageLocal().saveToken(res.token);
              await const SecureStorageLocal().saveUserDetails(res.userDetails);
              Get.offNamed(RouteNames.home);
            } else {
              appController.manageError(res.message);
            }
          } on HttpException catch (e) {
            appController.manageError(e.message);
          }
        },
        loadingWidget: Loading(vertical: size.height * 0.46),
      );
    }
  }
}
