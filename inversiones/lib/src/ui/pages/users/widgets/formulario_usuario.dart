import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/ui/pages/users/users_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';

class FormularioUsuario extends StatelessWidget {
  const FormularioUsuario(this.controller, this.mediaQuery);

  final UserController controller;
  final Size mediaQuery;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          TextFieldBase(
              textAlign: TextAlign.left,
              paddingHorizontal: 20,
              title: 'Nombres',
              controller: controller.nombres,
              textInputType: TextInputType.name,
              validateText: ValidateText.name),
          TextFieldBase(
              textAlign: TextAlign.left,
              title: 'Apellidos',
              controller: controller.apellidos,
              textInputType: TextInputType.name,
              validateText: ValidateText.name)
        ]),
        Row(children: [
          TextFieldBase(
              textAlign: TextAlign.left,
              paddingHorizontal: 20,
              title: 'Nombre usuario',
              controller: controller.nombreUsuario,
              textInputType: TextInputType.name,
              validateText: ValidateText.name),
          TextFieldBase(
              textAlign: TextAlign.left,
              title: 'Correo',
              controller: controller.correo,
              textInputType: TextInputType.emailAddress,
              validateText: ValidateText.email)
        ]),
        Obx(() {
          return !controller.rolesController.cargando.value
              ? Row(children: [
                  _selectRoles(mediaQuery, controller),
                  _registrarUsuarioBoton(mediaQuery, controller)
                ])
              : _mostrarLinearCargando(mediaQuery);
        })
      ])),
    );
  }

  Widget _selectRoles(Size mediaQuery, UserController controller) => Container(
      padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
      height: mediaQuery.height * 0.14,
      width: mediaQuery.width * 0.5,
      child: Obx(() => MultiSelectDialogField(
          initialValue: controller.rolesAsignados.value,
          dialogHeight:
              mediaQuery.height * (controller.items.value.length / 11),
          chipDisplay: MultiSelectChipDisplay<Roles>(scroll: true, scrollBar:HorizontalScrollBar(isAlwaysShown: true)),
          buttonIcon: const Icon(Icons.arrow_forward_ios_rounded),
          selectedColor: Colors.blue,
          buttonText: const Text('Roles', textAlign: TextAlign.center),
          title: const Center(child: Text("Seleccione roles")),
          items: controller.items.value,
          onConfirm: (items) => controller.rolesAsignados.value = items)));

  Widget _registrarUsuarioBoton(Size mediaQuery, UserController controller) =>
      Padding(
          padding: EdgeInsets.only(
              bottom: mediaQuery.height * 0.08, left: mediaQuery.width * 0.04),
          child: controller.registrar.value
              ? FilledButton.icon(
                  onPressed: () async => controller.registrarUsuario(),
                  icon: const FaIcon(FontAwesomeIcons.userCheck),
                  label: const Text("Registrar"))
              : FilledButton.icon(
                  onPressed: () async => controller.actualizarUsuario(),
                  icon: const FaIcon(FontAwesomeIcons.userPen),
                  label: const Text("Actualizar")));
}

Widget _mostrarLinearCargando(Size mediaQuery) => Padding(
    padding: EdgeInsets.symmetric(
        vertical: mediaQuery.height * 0.05,
        horizontal: mediaQuery.width * 0.06),
    child: SizedBox(
        height: mediaQuery.height * 0.01,
        width: mediaQuery.width * 0.9,
        child: const LinearProgressIndicator()));
