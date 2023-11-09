import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ListaClientes extends StatelessWidget {
  const ListaClientes({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ClientsController controller = Get.find<ClientsController>();
    return Obx(() {
      if (controller.status.value != 200) {
        return const Loading(
          vertical: 110,
        ).circularLoading();
      }
      return Column(
        children: [
          SizedBox(
            height: size.height * 0.32,
            width: size.width * 0.87,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.buscarCliente(value),
                  decoration: const InputDecoration(
                    labelText: 'Buscar',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                _listaClientes(controller, size),
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
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.52,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}",
          ),
        ),
        SizedBox(
          width: size.width * 0.25,
          child: Row(
            children: [
              IconButton(
                tooltip: 'editar',
                onPressed: () {
                  controller.loadClient(
                    controller.filtroClientes.value[index].cedula,
                  );
                },
                icon: const Icon(color: Colors.blue, Icons.edit),
              ),
              IconButton(
                tooltip: 'Crear credito',
                onPressed: () {},
                icon: const Icon(color: Colors.blue, Icons.monetization_on),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
