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
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class SignInController extends GetxController {
  SignInController(this.appController);

  final AppController appController;
  static final _auth = LocalAuthentication();
  final deviceInfoPlugin = DeviceInfoPlugin();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  String? idMovil;
  final Rx<String?> usuarioBiometria = Rx<String?>(null);
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Rx<bool> obscureText = Rx<bool>(true);
  Rx<bool> autenticado = Rx<bool>(false);

  @override
  Future<void> onInit() async {
    userDetails(await const SecureStorageLocal().userDetails);
    idMovil = await const SecureStorageLocal().idMovil;
    usuarioBiometria(await const SecureStorageLocal().usuarioBiometria);
    super.onInit();
  }

  void signIn(String username, String clave) {
    if (formKey.currentState!.validate()) {
      Get.showOverlay(
        asyncFunction: () async {
          try {
            final SignInResponse res = await const SignInHttp()
                .signInWithUsernameAndPassword(username, clave);
            final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

            if (res.status == 200) {
              await const SecureStorageLocal().saveIdMovil(androidInfo.id);
              await const SecureStorageLocal()
                  .saveToken(res.userDetails!.token);
              await const SecureStorageLocal().saveUserDetails(res.userDetails);
              Get.offNamed(RouteNames.navigationBar);
            } else {
              appController.manageError(res.message);
            }
          } on HttpException catch (e) {
            appController.manageError(e.message);
          }
        },
        loadingWidget: CargandoAnimacion(),
      );
    }
  }

  void authBiometrica() {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          final SignInResponse res = await const SignInHttp()
              .authBiometrica(usuarioBiometria.value!, idMovil!);

          if (res.status == 200) {
            await const SecureStorageLocal().saveToken(res.userDetails!.token);
            await const SecureStorageLocal().saveUserDetails(res.userDetails);
            Get.offNamed(RouteNames.navigationBar);
          } else {
            appController.manageError(res.message);
          }
        } on HttpException catch (e) {
          appController.manageError(e.message);
        }
      },
      loadingWidget: CargandoAnimacion(),
    );
  }

  Future<bool> _canAuth() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await _canAuth()) return false;
      return await _auth.authenticate(
          localizedReason: 'Usar los datos biometricos para ingresar',
          options: const AuthenticationOptions(biometricOnly: true),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Autenticacion biometrica',
              biometricHint: "",
              cancelButton: 'Cancelar',
            ),
          ]);
    } catch (e) {
      return false;
    }
  }
}
