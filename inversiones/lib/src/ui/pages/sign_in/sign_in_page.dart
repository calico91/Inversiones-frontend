import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_controller.dart';
import 'package:inversiones/src/ui/pages/sign_in/widgets/background_login.dart';
import 'package:inversiones/src/ui/pages/sign_in/widgets/card_container_login.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_fiel_login.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();

    return Obx(() {
      return Scaffold(
          body: BackgroundLogin(
            child: ListView(children: [
              Column(
                children: [
                  SizedBox(height: General.mediaQuery(context).height * 0.28),
                  CardContainerLogin(
                      child: Column(
                    children: [
                      SizedBox(
                          height: General.mediaQuery(context).height * 0.025),
                      Text('Login',
                          style: Theme.of(context).textTheme.headlineLarge),
                      SizedBox(
                          height: General.mediaQuery(context).height * 0.025),
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
                            SizedBox(
                                height:
                                    General.mediaQuery(context).height * 0.025),
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
                      SizedBox(
                          height: General.mediaQuery(context).height * 0.02),
                      _botonIngresar(controller, context)
                    ],
                  )),
                ],
              )
            ]),
          ),
          persistentFooterButtons: [
            Row(
              children: [
                SizedBox(
                    height: General.mediaQuery(context).height * 0.035,
                    child: TextButton(
                        onPressed: () =>
                            _mostrarCampoTextoServidor(context, controller),
                        child: const Text('Servidor'))),
                Expanded(child: Container()),
                const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    backgroundImage: AssetImage('assets/firma.jpg')),
                const Text('By cblandon', style: TextStyle(color: Colors.black))
              ],
            ),
          ],
          floatingActionButton: _botonAuthBiometrica(controller, context));
    });
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

  Widget _botonIngresar(SignInController controller, BuildContext context) =>
      TextButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
        onPressed: () => controller.signIn(
          controller.usernameController.value.text.trim(),
          controller.passwordController.value.text.trim(),
        ),
        child: Container(
          height: General.mediaQuery(context).height * 0.06,
          width: General.mediaQuery(context).width * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromRGBO(14, 90, 204, 1)])),
          child: const Center(
            child: Text('Ingresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      );

  // ignore: body_might_complete_normally_nullable
  Widget? _botonAuthBiometrica(
      SignInController controller, BuildContext context) {
    if (controller.usuarioBiometria.value != null) {
      return FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () async {
          final bool autBiometria = await controller.authenticate();
          if (autBiometria) {
            if (context.mounted) {
              controller.authBiometrica();
            }
          }
        },
        child: Container(
            height: General.mediaQuery(context).height * 0.1,
            width: General.mediaQuery(context).width * 0.15,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.blue, Color.fromRGBO(14, 90, 204, 1)])),
            child: const Icon(Icons.fingerprint)),
      );
    }
  }

  Object _mostrarCampoTextoServidor(
      BuildContext context, SignInController controller) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        content: TextFieldBase(
            textAlign: TextAlign.left,
            widthTextField: 0.6,
            title: 'Servidor',
            controller: controller.servidor,
            textInputType: TextInputType.multiline,
            validateText: ValidateText.observations),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Si')),
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No')),
        ],
      ),
    );
  }
}
