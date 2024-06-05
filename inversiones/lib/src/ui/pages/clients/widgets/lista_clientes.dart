import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';

class ListaClientes extends StatelessWidget {
  const ListaClientes({super.key});
  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.find<ClientsController>();
    return Obx(() {
      if (controller.clients.value.isEmpty) {
        return CustomCard(
          child: InkWell(
            onTap: () => controller.allClients(),
            child: Column(
              children: [
                const Text(
                  'Cargar clientes',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: General.mediaQuery(context).height * 0.2,
                  width: General.mediaQuery(context).width * 0.45, 
                  child: Image.asset(
                    'assets/clientes/cargar_clientes2.png',
                    width: double.infinity,
                    height: General.mediaQuery(context).height * 0.35,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return CustomCard(
        child: Column(
          children: [
            SizedBox(
              height: General.mediaQuery(context).height * 0.232,
              width: double.infinity,
              child: Column(
                children: [
                  Focus(
                    onFocusChange: (value) =>
                        controller.buscarCliente('', value),
                    child: TextFieldSearch(
                      controller: controller.buscarClienteCtrl,
                      labelText: 'Buscar cliente',
                      onChanged: (value) =>
                          controller.buscarCliente(value, true),
                    ),
                  ),
                  _listaClientes(controller, General.mediaQuery(context)),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _listaClientes(ClientsController controller, Size size) {
    final HomeController homeController = Get.find<HomeController>();
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filtroClientes.value.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: homeController.mostrarModulo(['SUPER'])
                ? () => controller
                    .loadClient(controller.filtroClientes.value[index].cedula)
                : null,
            child: Card(
              child: ListTile(
                title: _showClientTitle(controller, index, size),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _showClientTitle(ClientsController controller, int index, Size size) {
    return SizedBox(
      width: size.width * 0.51,
      child: Text(
        overflow: TextOverflow.ellipsis,
        "${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}",
      ),
    );
  }
}
