import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/ui/pages/permisos/permisos_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_body.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';

class PermisosPage extends StatelessWidget {
  const PermisosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = General.mediaQuery(context);
    final RolesController controller = Get.put(RolesController());

    return Scaffold(
      appBar: const AppBarCustom('Permisos'),
      body: CustomCardBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      const SizedBox(height: 15),
      SizedBox(
          width: mediaQuery.width * 0.8,
          height: mediaQuery.height * 0.08,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Seleccione un rol',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              fillColor: const Color.fromRGBO(165, 165, 165, 0.15),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[100]!, width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFF1B80BF),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
            ),
            items: [
              const DropdownMenuItem<String>(
                value: '',
                child: Text('Seleccione un rol'),
              ),
              ...controller.roles.value.map((role) => DropdownMenuItem<String>(
                  value: role.id.toString(), child: Text(role.name))),
            ],
            value: controller.rolSeleccionado.value.isEmpty
                ? ''
                : controller.rolSeleccionado.value,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.rolSeleccionado.value = newValue;
                if (newValue.isNotEmpty) {
                  controller.consultarPermisosRol(int.parse(newValue));
                } else {
                  controller.permisos.value = [];
                  controller.rolSeleccionado.value = '';
                }
              }
            },
          )),
      _selectPermisos(mediaQuery, controller),
      FilledButton.icon(
          onPressed: () => controller.asignarPermisos(),
          icon: const FaIcon(FontAwesomeIcons.unlockKeyhole),
          label: const Text("Asignar"))
    ])));

Widget _selectPermisos(Size mediaQuery, RolesController controller) => Padding(
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
                  border: Border.all(width: 0.8)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Obx(() => MultiSelectDialogField<Permiso>(
                decoration: const BoxDecoration(border: Border()),
                    initialValue: controller.permisos.value,
                    dialogHeight: mediaQuery.height *
                        (controller.items.value.length / 11),
                    chipDisplay: MultiSelectChipDisplay<Permiso>(
                        scroll: true,
                        scrollBar: HorizontalScrollBar(isAlwaysShown: true)),
                    buttonIcon: const Icon(Icons.arrow_drop_down),
                    selectedColor: ColoresApp.azulPrimario,
                    buttonText: const Text(
                      'Permisos',
                      textAlign: TextAlign.center,
                    ),
                    title: Center(
                        child: SizedBox(
                            width: mediaQuery.width * 0.5,
                            child: const Text(
                              "Seleccione permisos",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ))),
                    items: controller.items.value,
                    searchable: true,
                    onConfirm: (items) => controller.permisos.value = items,
                  )),
            ),
          ),
        ],
      ),
    );
