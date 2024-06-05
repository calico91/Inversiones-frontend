import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class DrawerMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return NavigationDrawer(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              headerDrawer(context),
              if (controller.mostrarModulo(['SUPER']))
                _opciones(
                  Icons.data_saver_off_sharp,
                  'Reportes',
                  () => Get.toNamed(RouteNames.reportes),
                ),
              if (controller.mostrarModulo(['SUPER']))
                _opciones(
                  Icons.admin_panel_settings_outlined,
                  'Usuarios',
                  () => Get.toNamed(RouteNames.users),
                ),
              _opciones(
                Icons.fingerprint_outlined,
                'Asignar biometria',
                () =>
                    controller.vincularDispositivo(General.mediaQuery(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerDrawer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15 + MediaQuery.of(context).padding.top,
        bottom: 15,
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/maelo.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _opciones(IconData icono, String titulo, VoidCallback accion) {
    return ListTile(
      onTap: accion,
      leading: Icon(
        icono,
        color: Colors.blue,
      ),
      title: Text(titulo),
    );
  }
}
