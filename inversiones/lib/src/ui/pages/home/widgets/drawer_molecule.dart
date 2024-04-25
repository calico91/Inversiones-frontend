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
              _opciones(
                Icons.person_2_outlined,
                'Clientes',
                () => Get.toNamed(RouteNames.clients),
              ),
              _opciones(
                Icons.monetization_on_outlined,
                'Creditos',
                () => Get.toNamed(RouteNames.credits),
              ),
              if (controller.mostrarModulo(['ADMIN']))
                _opciones(
                  Icons.data_saver_off_sharp,
                  'Reportes',
                  () => Get.toNamed(RouteNames.reportes),
                ),
              _opciones(
                Icons.mobile_friendly,
                'Asignar dispositivo',
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
