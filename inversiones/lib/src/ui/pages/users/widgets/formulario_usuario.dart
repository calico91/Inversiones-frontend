import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/ui/pages/users/users_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

class FormularioUsuario extends StatelessWidget {
  const FormularioUsuario(this.controller, this.mediaQuery, {super.key});

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
              paddingHorizontal: 10,
              hintText: 'Nombres',
              controller: controller.nombres,
              textInputType: TextInputType.name,
              validateText: ValidateText.name),
          TextFieldBase(
              textAlign: TextAlign.left,
              hintText: 'Apellidos',
              controller: controller.apellidos,
              textInputType: TextInputType.name,
              validateText: ValidateText.name)
        ]),
        Row(children: [
          TextFieldBase(
              textAlign: TextAlign.left,
              paddingHorizontal: 10,
              hintText: 'Nombre usuario',
              controller: controller.nombreUsuario,
              textInputType: TextInputType.name,
              validateText: ValidateText.name),
          TextFieldBase(
              textAlign: TextAlign.left,
              hintText: 'Correo',
              controller: controller.correo,
              textInputType: TextInputType.emailAddress,
              validateText: ValidateText.email)
        ]),
        Obx(() {
          return !controller.rolesController.cargando.value
              ? Column(children: [
                  _selectRoles(mediaQuery, controller),
                  _registrarUsuarioBoton(mediaQuery, controller)
                ])
              : _mostrarLinearCargando(mediaQuery);
        })
      ])),
    );
  }

  Widget _selectRoles(Size mediaQuery, UserController controller) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.028,
          vertical: mediaQuery.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(165, 165, 165, 0.15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 0.8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Obx(() => MultiSelectDialogField<Roles>(
                      initialValue: controller.rolesAsignados.value,
                      dialogHeight: mediaQuery.height *
                          (controller.items.value.length / 11),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      buttonIcon: const Icon(Icons.arrow_forward_ios_rounded),
                      selectedColor: ColoresApp.azulPrimario,
                      buttonText: Text(
                        _buildSelectedRolesText(
                            controller.rolesAsignados.value),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      decoration: const BoxDecoration(border: Border()),
                      title: const Center(child: Text("Seleccione roles")),
                      items: controller.items.value,
                      onConfirm: (items) =>
                          controller.rolesAsignados.value = items,
                    )),
              ),
            ),
          ],
        ),
      );

  String _buildSelectedRolesText(List<Roles> roles) {
    if (roles.isEmpty) {
      return 'Seleccione roles';
    }
    const int maxRolesToShow = 3;
    final displayedRoles =
        roles.take(maxRolesToShow).map((role) => role.name).join(', ');
    return roles.length > maxRolesToShow
        ? '$displayedRoles...'
        : displayedRoles;
  }

  Widget _registrarUsuarioBoton(Size mediaQuery, UserController controller) =>
      controller.registrar.value
          ? FilledButton.icon(
              onPressed: () async => controller.registrarUsuario(),
              icon: const FaIcon(FontAwesomeIcons.userCheck),
              label: const Text("Registrar"))
          : FilledButton.icon(
              onPressed: () async => controller.actualizarUsuario(),
              icon: const FaIcon(FontAwesomeIcons.userPen),
              label: const Text("Actualizar"));
}

Widget _mostrarLinearCargando(Size mediaQuery) => Padding(
    padding: EdgeInsets.symmetric(
        vertical: mediaQuery.height * 0.05,
        horizontal: mediaQuery.width * 0.06),
    child: SizedBox(
        height: mediaQuery.height * 0.01,
        width: mediaQuery.width * 0.9,
        child: const LinearProgressIndicator()));
