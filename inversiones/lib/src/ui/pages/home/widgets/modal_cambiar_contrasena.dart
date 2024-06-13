import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_fiel_login.dart';

class ModalCambiarContrasena extends StatelessWidget {
  const ModalCambiarContrasena(this.controller);

  final HomeController controller;
  @override
  Widget build(BuildContext context) => AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        title: const Text('Cambiar contraseña', textAlign: TextAlign.center),
        content: SizedBox(
          height: General.mediaQuery(context).height * 0.43,
          child: Form(
            key: controller.formKeyCambiarContrasena,
            child: Column(
              children: [
                Obx(
                  () => TextFieldLogin(
                    suffixIcon:
                        _mostrarContrasena(controller.ocultarContrasenaActual),
                    title: 'Contraseña actual',
                    widthTextField: 0.5,
                    fillColor: Colors.white,
                    obscureText: controller.ocultarContrasenaActual.value,
                    controller: controller.contrasenaActual,
                    validateText: ValidateText.username,
                  ),
                ),
                Obx(
                  () => TextFieldLogin(
                    suffixIcon:
                        _mostrarContrasena(controller.ocultarContrasenaNueva),
                    title: 'Contraseña nueva',
                    widthTextField: 0.5,
                    fillColor: Colors.white,
                    obscureText: controller.ocultarContrasenaNueva.value,
                    controller: controller.contrasenaNueva,
                    validateText: ValidateText.username,
                  ),
                ),
                Obx(
                  () => TextFieldLogin(
                    suffixIcon: _mostrarContrasena(
                        controller.ocultarConfirmarContrasena),
                    title: 'Confirmar contraseña',
                    widthTextField: 0.5,
                    fillColor: Colors.white,
                    obscureText: controller.ocultarConfirmarContrasena.value,
                    controller: controller.confirmarContrasena,
                    validateText: ValidateText.username,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: General.mediaQuery(context).width * 0.38,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text('Enviar', textAlign: TextAlign.center),
                    onPressed: () => _cambiarContrasena(controller),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [_cerrar(context, controller)],
      );
}

Widget _mostrarContrasena(RxBool campo) => IconButton(
      onPressed: () => campo.value = !campo.value,
      icon: campo.value
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );

Widget _cerrar(BuildContext context, HomeController controller) => IconButton(
    iconSize: 32,
    tooltip: 'Cerrar',
    onPressed: () {
      controller.contrasenaActual.clear();
      controller.contrasenaNueva.clear();
      controller.confirmarContrasena.clear();
      controller.ocultarContrasenaActual.value = true;
      controller.ocultarContrasenaNueva.value = true;
      controller.ocultarConfirmarContrasena.value = true;
      Navigator.pop(context);
    },
    icon: const Icon(Icons.close_rounded),
    color: Colors.grey);

void _cambiarContrasena(HomeController controller) {
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
