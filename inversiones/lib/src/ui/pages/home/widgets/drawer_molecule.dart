import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/home/widgets/modal_cambiar_contrasena.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';

class DrawerMolecule extends StatelessWidget {
  const DrawerMolecule({super.key});

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
                _opciones(Icons.data_saver_off_sharp, 'Reportes',
                    () => Get.toNamed(RouteNames.reportes)),
              if (controller.mostrarModulo(['SUPER']))
                _opciones(FontAwesomeIcons.circleUser, 'Usuarios',
                    () => Get.toNamed(RouteNames.users)),
              if (controller.mostrarModulo(['SUPER']))
                _opciones(Icons.admin_panel_settings_outlined, 'Roles',
                    () => Get.toNamed(RouteNames.roles)),
              _opciones(Icons.fingerprint_outlined, 'Activar huella',
                  () => controller.vincularDispositivo()),
              _opciones(Icons.password_outlined, 'Cambiar contraseña',
                  () => _mostrarModalCambiarContrasena(context, controller)),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerDrawer(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 15 + MediaQuery.of(context).padding.top, bottom: 15),
        child: const Column(
          children: [
            CircleAvatar(
                radius: 52, backgroundImage: AssetImage('assets/maelo.jpg')),
          ],
        ));
  }

  Widget _opciones(IconData icono, String titulo, VoidCallback accion,
      {Color? color}) {
    return ListTile(
        onTap: accion,
        leading: Icon(icono, color: color ?? ColoresApp.azulPrimario,size: 27,),
        title: Row(
          children: [
            Text(titulo),
            Expanded(child: Container()),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ));
  }

  Future _mostrarModalCambiarContrasena(
          BuildContext context, HomeController controller) =>
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ModalCambiarContrasena(controller));
}
