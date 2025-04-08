import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/cambiar_contrasena/cambiar_contrasena_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/button_actions.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_body.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_fiel_login.dart';

class CambiarContrasenaPage extends StatelessWidget {
  const CambiarContrasenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CambiarContrasenaController controller =
        Get.put(CambiarContrasenaController());

    return Scaffold(
      appBar: const AppBarCustom('Cambiar contraseña'),
      body: CustomCardBody(
        child: Form(
          key: controller.formKeyCambiarContrasena,
          child: CustomCard(
            child: Column(
              children: [
                Obx(
                  () => TextFieldLogin(
                    suffixIcon:
                        _mostrarContrasena(controller.ocultarContrasenaActual),
                    hintText: 'Contraseña actual',
                    widthTextField: 0.5,
                    obscureText: controller.ocultarContrasenaActual.value,
                    controller: controller.contrasenaActual,
                    validateText: ValidateText.username,
                  ),
                ),
                SizedBox(height: General.mediaQuery(context).height * 0.02),
                Obx(
                  () => TextFieldLogin(
                    suffixIcon:
                        _mostrarContrasena(controller.ocultarContrasenaNueva),
                    hintText: 'Contraseña nueva',
                    widthTextField: 0.5,
                    obscureText: controller.ocultarContrasenaNueva.value,
                    controller: controller.contrasenaNueva,
                    validateText: ValidateText.username,
                  ),
                ),
                SizedBox(height: General.mediaQuery(context).height * 0.02),
                Obx(
                  () => TextFieldLogin(
                    suffixIcon: _mostrarContrasena(
                        controller.ocultarConfirmarContrasena),
                    hintText: 'Confirmar contraseña',
                    widthTextField: 0.5,
                    obscureText: controller.ocultarConfirmarContrasena.value,
                    controller: controller.confirmarContrasena,
                    validateText: ValidateText.username,
                  ),
                ),
                SizedBox(height: General.mediaQuery(context).height * 0.03),
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: General.mediaQuery(context).width * 0.38,
                    child: ButtonActions(
                        onPressed: () => _cambiarContrasena(controller),
                        height: 0.05,
                        width: 0.44,
                        label: 'ENVIAR',
                        fontSize: 17)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _mostrarContrasena(RxBool campo) => IconButton(
      onPressed: () => campo.value = !campo.value,
      icon: campo.value
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );

void _cambiarContrasena(CambiarContrasenaController controller) {
  if (controller.formKeyCambiarContrasena.currentState!.validate()) {
    if (controller.confirmarContrasena.text.trim() !=
        controller.contrasenaNueva.text.trim()) {
      controller.appController
          .manageError('La contraseña nueva y la confirmacion no coinciden');
    } else {
      controller.cambiarContrasena();
    }
  }
}
