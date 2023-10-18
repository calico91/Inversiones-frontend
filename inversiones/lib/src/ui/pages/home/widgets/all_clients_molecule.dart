import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class AllClientsMolecule extends StatelessWidget {
  const AllClientsMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final HomeController controller = Get.find<HomeController>();

    return Obx(
      () {
        if (controller.loading) {
          return Loading();
        }
        return ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: _mostrarDatosCliente(controller, index, size),
            );
          },
        );
      },
    );
  }

  Widget _mostrarDatosCliente(HomeController controller, int index, Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: Text(
              overflow: TextOverflow.ellipsis,
              "${controller.clients[index].nombres} ${controller.clients[index].apellidos}"),
        ),
        SizedBox(
          width: size.width * 0.4,
          child: Text(
              textAlign: TextAlign.right, controller.clients[index].cedula),
        )
      ],
    );
  }
}
