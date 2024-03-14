import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/sing_in_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/sing_in_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';
import 'package:local_auth/local_auth.dart';

class SignInController extends GetxController {
  SignInController(this.appController);

  final AppController appController;
  static final _auth = LocalAuthentication();
  final deviceInfoPlugin = DeviceInfoPlugin();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  final Rx<String?> password = Rx<String?>(null);

  Rx<bool> obscureText = Rx<bool>(true);
  Rx<bool> autenticado = Rx<bool>(false);

  @override
  Future<void> onInit() async {
    userDetails(await const SecureStorageLocal().userDetails);
    password(await const SecureStorageLocal().password);
    super.onInit();
  }

  void signIn(
    Size size,
    String username,
    String clave,
    bool validarFormulario,
  ) {
    if (formKey.currentState!.validate() || !validarFormulario) {
      Get.showOverlay(
        asyncFunction: () async {
          try {
            final SignInResponse res =
                await const SignInHttp().signInWithUsernameAndPassword(
              username,
              clave,
            );
            password(passwordController.value.text.trim());

            if (res.status == 200) {
              await const SecureStorageLocal().savePassword(password.value);
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

  Future<bool> _canAuth() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await _canAuth()) return false;
      return await _auth.authenticate(
        localizedReason: 'Necesito tu conf',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      return false;
    }
  }
}
