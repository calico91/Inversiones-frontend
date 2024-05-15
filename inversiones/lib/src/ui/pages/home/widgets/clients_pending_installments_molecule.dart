import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ClientsPendingInstallmentsMolecule extends StatelessWidget {
  const ClientsPendingInstallmentsMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(
      () {
        if (controller.loading) {
          return const Loading(
            horizontal: 0.43,
            vertical: 0.19);
        } else if (!controller.loading && controller.clients.isEmpty) {
          return Column(
            children: [
              Image.asset(
                'assets/sin_creditos_pendientes.png',
                width: double.infinity,
                height: General.mediaQuery(context).height * 0.35,
              ),
              const Text(
                'No hay créditos pendientes.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (_, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Get.toNamed(RouteNames.payFee);
                  controller.idCliente(controller.clients[index].idCliente);
                  controller.idCredito(controller.clients[index].idCredito);
                  controller.nombreCliente(
                    '${controller.clients[index].nombres} ${controller.clients[index].apellidos}',
                  );
                },
                title: _showClientTitle(
                  controller,
                  index,
                  General.mediaQuery(context),
                ),
                subtitle: _showClientSubtitle(
                  controller,
                  index,
                  General.mediaQuery(context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///titulo que se muestra informacion clientes
  Widget _showClientTitle(HomeController controller, int index, Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.49,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "${controller.clients[index].idCredito}.${controller.clients[index].nombres} ${controller.clients[index].apellidos}",
          ),
        ),
        SizedBox(
          width: size.width * 0.35,
          child: Text(
            textAlign: TextAlign.right,
            controller.clients[index].cedula!,
          ),
        ),
      ],
    );
  }

  Widget _showClientSubtitle(HomeController controller, int index, Size size) {
    final String valorCuota =
        General.formatoMoneda(controller.clients[index].valorCuota);
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.37,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "Fecha cuota:${controller.clients[index].fechaCuota}",
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: size.width * 0.44,
          child: Text(
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            "Cuota normal: $valorCuota",
          ),
        ),
      ],
    );
  }
}
