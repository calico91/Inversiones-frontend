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

  @override
  void onClose() {
    //usernameController.dispose();
    //passwordController.dispose();
    super.onClose();
  }

  void signIn() {
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
              Get.offNamed(RouteNames.home, arguments: res.userDetails);
            } else {
              appController.manageError(res.message);
            }
          } on HttpException catch (e) {
            appController.manageError(e.message);
          }
        },
        loadingWidget: const Loading().circularLoading(),
      );
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().length < 5) {
      return 'Wrong username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return 'Invalid password';
    } else if (value.length < 6) {
      return 'Password min length 6';
    }
    return null;
  }
}
