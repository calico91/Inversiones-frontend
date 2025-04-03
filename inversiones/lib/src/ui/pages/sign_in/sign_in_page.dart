import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_controller.dart';
import 'package:inversiones/src/ui/pages/sign_in/widgets/background_login.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
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
          body: ListView(
            children: [
              const BackgroundLogin(),
              SizedBox(height: General.mediaQuery(context).height * 0.05),
              _mostrarTituloInciarSesion(),
              SizedBox(height: General.mediaQuery(context).height * 0.03),
              Form(
                key: controller.formKeyAuth,
                child: Column(
                  children: [
                    TextFieldLogin(
                      controller: controller.usernameController,
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      validateText: ValidateText.username,
                      hintText: 'Usuario',
                    ),
                    Obx(
                      () => TextFieldLogin(
                        suffixIcon: _mostrarcontrasena(controller),
                        obscureText: controller.obscureText.value,
                        controller: controller.passwordController,
                        prefixIcon: const Icon(Icons.lock_outline),
                        validateText: ValidateText.password,
                        hintText: 'Contraseña',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: General.mediaQuery(context).height * 0.02),
              _botonIngresar(controller, context)
            ],
          ),
          persistentFooterButtons: [
            Row(
              children: [
                TextButton(
                    onPressed: () =>
                        _mostrarCampoTextoServidor(context, controller),
                    child: const Text('Servidor')),
                Expanded(child: Container()),
                const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    backgroundImage: AssetImage('assets/firma.jpg')),
                const Text('By cblandon', style: TextStyle(color: Colors.black))
              ],
            ),
          ],
          floatingActionButton:
              _mostrarBotonAuthBiometrica(controller, context));
    });
  }

  Widget _mostrarcontrasena(SignInController controller) {
    return IconButton(
      onPressed: () =>
          controller.obscureText.value = !controller.obscureText.value,
      icon: controller.obscureText.value
          ? const Icon(Icons.visibility_off_outlined)
          : const Icon(Icons.visibility_outlined),
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
            color: ColoresApp.azulPrimario,
          ),
          child: const Center(
            child: Text('Ingresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      );

  // ignore: body_might_complete_normally_nullable
  Widget? _mostrarBotonAuthBiometrica(
      SignInController controller, BuildContext context) {
    if (controller.usuarioBiometria.value != null) {
      return FloatingActionButton(
        elevation: 0,
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
                shape: BoxShape.circle, color: ColoresApp.azulPrimario),
            child: const Icon(
              Icons.fingerprint,
              size: 45,
            )),
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
        content: Form(
          key: controller.formServidor,
          child: TextFieldBase(
              textAlign: TextAlign.left,
              widthTextField: 0.6,
              title: 'Url de servidor',
              controller: controller.urlServidor,
              textInputType: TextInputType.multiline,
              validateText: ValidateText.observations),
        ),
        actions: [
          Center(
              child: SizedBox(
                  width: General.mediaQuery(context).width * 0.4,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Guardar', textAlign: TextAlign.center),
                      onPressed: () async =>
                          controller.guardarUrlServidor(context)))),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _mostrarTituloInciarSesion() => const Center(
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
