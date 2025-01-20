import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
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
                  width: General.mediaQuery(context).width * 0.6,
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
        child: SizedBox(
          height: General.mediaQuery(context).height * 0.38,
          width: double.infinity,
          child: Column(
            children: [
              Focus(
                onFocusChange: (value) => controller.buscarCliente('', value),
                child: TextFieldSearch(
                  controller: controller.buscarClienteCtrl,
                  labelText: 'Buscar cliente',
                  onChanged: (value) => controller.buscarCliente(value, true),
                ),
              ),
              _listaClientes(controller, General.mediaQuery(context)),
            ],
          ),
        ),
      );
    });
  }

  Widget _listaClientes(ClientsController controller, Size size) => Expanded(
      child: ListView.builder(
          itemCount: controller.filtroClientes.value.length,
          itemBuilder: (_, index) {
            return Card(
                elevation: 5,
                child: ListTile(
                  title: _mostrarTitulo(controller, index, size),
                  subtitle: _mostrarSubtitulos(controller, index, size),
                ));
          }));

  Widget _mostrarTitulo(ClientsController controller, int index, Size size) =>
      SizedBox(
          width: size.width * 0.51,
          child: Center(
              child: Text(
                  overflow: TextOverflow.ellipsis,
                  "${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}")));

  Widget _mostrarSubtitulos(
          ClientsController controller, int index, Size size) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _mostrarBotonSubtitulos(
            "Consultar cliente",
            () => controller.loadClient(
                controller.filtroClientes.value[index].cedula, false),
            Icons.person_search),
        _mostrarBotonSubtitulos(
            "Editar cliente",
            () => controller.loadClient(
                controller.filtroClientes.value[index].cedula, true),
            Icons.edit),
        _mostrarBotonSubtitulos("Ver imagenes", () {}, Icons.image_search),
      ]);

  Widget _mostrarBotonSubtitulos(
          String tooltip, Function() accion, IconData icono) =>
      IconButton(
          color: Colors.blue,
          onPressed: accion,
          icon: Icon(icono),
          tooltip: tooltip,
          iconSize: 30);
}
