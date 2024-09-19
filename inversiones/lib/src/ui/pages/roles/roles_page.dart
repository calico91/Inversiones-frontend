import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/roles/roles_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';

class RolesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = General.mediaQuery(context);
    final RolesController controller = Get.put(RolesController());

    return Scaffold(
      appBar: const AppBarCustom('Roles'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Asignar permisos',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17)))),
          Obx(
            () => !controller.cargando.value
                ? _selectRoles(mediaQuery, controller)
                : const LinearProgressIndicator(),
          )
        ],
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
                  print('voy hacer la peticion');
                }
              }))
    ])));
