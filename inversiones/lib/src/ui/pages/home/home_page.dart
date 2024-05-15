import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/home/widgets/clients_pending_installments_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/drawer_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/simulate_credit_molecule.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar_style/tittle_appbar.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      drawer: DrawerMolecule(),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Obx(
          () => Center(
              child: TittleAppbar(
                  controller.userDetails.value.username?.toUpperCase() ?? '')),
        ),
        actions: [
          IconButton(
            onPressed: () => _confirmacionCerrarSesion(controller, context),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              _seleccionarFechaConsulta(controller, context),
              _mostrarCuotasPendientes(context),
              SimulateCreditMolecule(),
            ],
          ),
        ],
      ),
    );
  }

  Future _confirmacionCerrarSesion(
          HomeController controller, BuildContext context) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(child: Text('Desea cerrar sesion')),
          actions: [
            TextButton(
              onPressed: () => controller.logout(),
              child: const Text('Si'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        ),
      );

  Widget _seleccionarFechaConsulta(
          HomeController controller, BuildContext context) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldCalendar(
                height: General.mediaQuery(context).height * 0.03,
                controller: controller.fechafiltro,
                onTap: () async => General.showCalendar(
                  context,
                  controller.fechafiltro,
                ),
                title: 'Seleccione fecha',
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: General.mediaQuery(context).height * 0.05,
                width: General.mediaQuery(context).width * 0.1,
                child: IconButton(
                  onPressed: () => controller.loadClientsPendingInstallments(
                    controller.fechafiltro.text,
                  ),
                  icon: const Icon(size: 25, Icons.info, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _mostrarCuotasPendientes(BuildContext context) => SizedBox(
        height: General.mediaQuery(context).height * 0.45,
        child: const CustomCard(child: ClientsPendingInstallmentsMolecule()),
      );
}
