import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/ui/pages/roles/roles_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_body.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = General.mediaQuery(context);
    final RolesController controller = Get.put(RolesController());

    return Scaffold(
      appBar: const AppBarCustom('Roles'),
      body: CustomCardBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text('Asignar permisos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)))),
            Obx(
              () => !controller.cargando.value
                  ? _selectRoles(mediaQuery, controller)
                  : const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _selectRoles(Size mediaQuery, RolesController controller) => SizedBox(
    width: double.infinity,
    child: CustomCard(
        child: Column(children: [
      SizedBox(
          width: mediaQuery.width * 0.8,
          height: mediaQuery.height * 0.06,
          child: DropdownButton<String>(
              isExpanded: true,
              items: [
                const DropdownMenuItem<String>(
                  child: Text('Seleccione un rol'),
                ),
                ...controller.roles.value.map((role) =>
                    DropdownMenuItem<String>(
                        value: role.id.toString(), child: Text(role.name)))
              ],
              value: controller.rolSeleccionado.value.isEmpty
                  ? null
                  : controller.rolSeleccionado.value,
              onChanged: (String? newValue) {
                controller.rolSeleccionado.value = newValue ?? '';
                if (newValue != null) {
                  controller.consultarPermisosRol(
                      int.parse(controller.rolSeleccionado.value));
                } else {
                  controller.permisos.value = [];
                }
              })),
      _selectPermisos(mediaQuery, controller),
      FilledButton.icon(
          onPressed: () => controller.asignarPermisos(),
          icon: const FaIcon(FontAwesomeIcons.unlockKeyhole),
          label: const Text("Asignar"))
    ])));

Widget _selectPermisos(Size mediaQuery, RolesController controller) =>
    Container(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
        height: mediaQuery.height * 0.14,
        width: mediaQuery.width * 0.95,
        child: Obx(() => MultiSelectDialogField(
            initialValue: controller.permisos.value,
            dialogHeight:
                mediaQuery.height * (controller.items.value.length / 11),
            chipDisplay: MultiSelectChipDisplay<Permiso>(
                scroll: true,
                scrollBar: HorizontalScrollBar(isAlwaysShown: true)),
            buttonIcon: const Icon(Icons.arrow_drop_down),
            selectedColor: ColoresApp.azulPrimario,
            buttonText: const Text('Permisos', textAlign: TextAlign.center),
            title: Center(
                child: SizedBox(
                    width: mediaQuery.width * 0.5,
                    child: const Text("Seleccione permisos",
                        maxLines: 2, overflow: TextOverflow.ellipsis))),
            items: controller.items.value,
            searchable: true,
            onConfirm: (items) => controller.permisos.value = items)));
