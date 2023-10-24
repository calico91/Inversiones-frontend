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
        if (controller.clients.isEmpty) {
          return const Loading(
            vertical: 110,
          );
        }
        return ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: _showClientTitle(controller, index, size),
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
          width: size.width * 0.5,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "${controller.clients[index].nombres} ${controller.clients[index].apellidos}",
          ),
        ),
        SizedBox(
          width: size.width * 0.4,
          child: Text(
            textAlign: TextAlign.right,
            controller.clients[index].cedula,
          ),
        ),
      ],
    );
  }
}
