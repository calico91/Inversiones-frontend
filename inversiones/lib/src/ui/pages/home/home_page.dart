import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/home/widgets/clients_pending_installments_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/drawer_molecule.dart';
import 'package:inversiones/src/ui/pages/home/widgets/simulate_credit_molecule.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

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
                          onPressed: () {
                            controller.loadClientsPendingInstallments(
                              controller.fechafiltro.text,
                            );
                          },
                          icon: const Icon(
                            size: 25,
                            Icons.info,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: General.mediaQuery(context).height * 0.35,

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
