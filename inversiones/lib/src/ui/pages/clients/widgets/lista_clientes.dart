import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ListaClientes extends StatelessWidget {
  const ListaClientes({super.key});
  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.find<ClientsController>();
    return Obx(() {
      if (controller.status.value != 200) {
        return Loading(
          vertical: General.mediaQuery(context).height * 0.1,
        );
      }
      return Column(
        children: [
          SizedBox(
            height: General.mediaQuery(context).height * 0.32,
            width: General.mediaQuery(context).width * 0.87,
            child: Column(
              children: [
                TextFieldSearch(
                  labelText: 'Buscar cliente',
                  onChanged: (value) => controller.buscarCliente(value),
                ),
                _listaClientes(controller, General.mediaQuery(context)),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _listaClientes(ClientsController controller, Size size) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filtroClientes.value.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              title: _showClientTitle(controller, index, size),
            ),
          );
        },
      ),
    );
  }

  Widget _showClientTitle(ClientsController controller, int index, Size size) {
    final HomeController homeController = Get.find<HomeController>();

    return Row(
      children: [
        SizedBox(
          width: size.width * 0.51,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}",
          ),
        ),
        SizedBox(
          width: size.width * 0.25,
          child: Row(
            children: [
              if (homeController.mostrarModulo(['ADMIN']))
                IconButton(
                  tooltip: 'editar',
                  onPressed: () {
                    controller.loadClient(
                      controller.filtroClientes.value[index].cedula,
                      size,
                    );
                  },
                  icon: const Icon(color: Colors.blue, Icons.edit),
                ),
              IconButton(
                tooltip: 'Crear credito',
                onPressed: () {
                  Get.toNamed(
                    RouteNames.credits,
                    parameters: {
                      'cedula': controller.filtroClientes.value[index].cedula,
                      'nombreCliente':
                          "${controller.filtroClientes.value[index].nombres.split(' ').first} ${controller.filtroClientes.value[index].apellidos}"
                    },
                  );
                },
                icon: const Icon(color: Colors.blue, Icons.monetization_on),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
