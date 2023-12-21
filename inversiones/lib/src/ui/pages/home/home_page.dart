import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/home/widgets/clients_pending_installments_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/drawer_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/simulate_credit_molecule.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      drawer: DrawerMolecule(),
      appBar: AppBar(
        title: Center(
          child: Obx(
            () => controller.userDetails.value.username != null
                ? Text(controller.userDetails.value.username!.toUpperCase())
                : Container(),
          ),
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
              SizedBox(
                height: General.mediaQuery(context).height * 0.3,

                /// lista cuotas pendientes anteriores a la fecha de hoy
                child: const ClientsPendingInstallmentsMolecule(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                /// simular credito
                child: SimulateCreditMolecule(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _confirmacionCerrarSesion(
    HomeController controller,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Desea cerrar sesion'),
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
  }
}
