import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/users/users_controller.dart';
import 'package:inversiones/src/ui/pages/users/widgets/formulario_usuario.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = General.mediaQuery(context);
    final UserController controller = Get.put(UserController());

    return Scaffold(
        appBar: const AppBarCustom('Usuarios'),
        body: SingleChildScrollView(
          child: Column(children: [
            Form(
                key: controller.formKeyUsuario,
                child: FormularioUsuario(controller, mediaQuery)),
            Obx(() {
              return CustomCard(
                  child: SizedBox(
                      height: mediaQuery.height * 0.47,
                      width: double.infinity,
                      child: controller.cargando.value
                          ? const Loading(horizontal: 0.4, vertical: 0.2)
                          : controller.usuarios.value.isEmpty
                              ? const Center(
                                  child: Text('No hay usuarios creados'))
                              : Column(children: [
                                  Focus(
                                      onFocusChange: (value) =>
                                          controller.buscarUsuario('', value),
                                      child: TextFieldSearch(
                                          controller:
                                              controller.buscarUsuarioCtrl,
                                          labelText: 'Buscar usuario',
                                          onChanged: (value) => controller
                                              .buscarUsuario(value, true))),
                                  _listaUsuarios(controller, mediaQuery)
                                ])));
            })
          ]),
        ));
  }
}

Widget _listaUsuarios(UserController controller, Size size) {
  return Expanded(
      child: ListView.builder(
          itemCount: controller.filtroUsuarios.value.length,
          itemBuilder: (_, index) {
            return Card(
                child:
                    ListTile(title: _showClientTitle(controller, index, size)));
          }));
}

Widget _showClientTitle(UserController controller, int index, Size size) =>
    SizedBox(
        width: size.width * 0.51,
        child: Text(
            overflow: TextOverflow.ellipsis,
            "${controller.filtroUsuarios.value[index].firstname} ${controller.filtroUsuarios.value[index].lastname}"));
