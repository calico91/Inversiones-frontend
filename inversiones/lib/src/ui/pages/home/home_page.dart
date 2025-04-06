import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/home/widgets/clients_pending_installments_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/drawer_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/simulate_credit_molecule.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_body.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
        drawer: const DrawerMolecule(),
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: ColoresApp.azulPrimario,
          title: Obx(() => Text(
                controller.nombreUsuario.value,
                style: const TextStyle(fontSize: 17),
              )),
          actions: [
            IconButton(
              onPressed: () => _confirmacionCerrarSesion(controller, context),
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: CustomCardBody(
          child: Column(children: [
            _mostrarCuotasPendientes(controller, context),
            SimulateCreditMolecule()
          ]),
        ));
  }

  Future _confirmacionCerrarSesion(
      HomeController controller, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        title: const Center(child: Text('Desea cerrar sesión')),
        actions: [
          TextButton(
            onPressed: () => controller.logout(),
            child: const Text('Sí'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  Widget _mostrarCuotasPendientes(
      HomeController controller, BuildContext context) {
    return CustomCard(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: General.mediaQuery(context).height * 0.47,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldCalendar(
                      controller: controller.fechafiltro,
                      onTap: () async =>
                          General.showCalendar(context, controller.fechafiltro),
                      title: 'Seleccione fecha',
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: General.mediaQuery(context).height * 0.05,
                      width: General.mediaQuery(context).width * 0.1,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        tooltip: 'Consultar cuotas pendientes',
                        onPressed: () =>
                            controller.loadClientsPendingInstallments(
                                controller.fechafiltro.text),
                        icon: const Icon(
                            size: 30,
                            Icons.refresh_outlined,
                            color: ColoresApp.azulPrimario),
                      ),
                    ),
                  ],
                ),
                const ClientsPendingInstallmentsMolecule(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
