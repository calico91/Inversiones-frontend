import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_fiel_login.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: General.mediaQuery(context).width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFieldLogin(
                    controller: controller.usernameController,
                    prefixIcon: const Icon(Icons.person),
                    validateText: ValidateText.username,
                    hintText: 'Usuario',
                  ),
                  SizedBox(height: General.mediaQuery(context).height * 0.02),
                  Obx(
                    () => TextFieldLogin(
                      suffixIcon: _mostrarcontrasena(controller),
                      obscureText: controller.obscureText.value,
                      controller: controller.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      validateText: ValidateText.password,
                      hintText: 'Contraseña',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ingresar',
                    style: TextStyle(
                        color: const Color.fromRGBO(31, 33, 36, 0.8),
                        fontSize: General.mediaQuery(context).height * 0.05)),
                IconButton(
                  splashRadius: 1,
                  color: const Color.fromRGBO(31, 33, 36, 0.8),
                  iconSize: General.mediaQuery(context).height * 0.06,
                  onPressed: () =>
                      controller.signIn(General.mediaQuery(context)),
                  icon: const Icon(Icons.arrow_circle_right_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mostrarcontrasena(SignInController controller) {
    return IconButton(
      onPressed: () =>
          controller.obscureText.value = !controller.obscureText.value,
      icon: controller.obscureText.value
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }
}
