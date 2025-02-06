import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';

class DialogListaClientes extends StatelessWidget {
  final CreditsController controller = Get.find<CreditsController>();

  DialogListaClientes({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Text(
        textAlign: TextAlign.center,
        'Seleccione cliente',
      ),
      content: Obx(
        () => Column(
          children: [
            TextFieldSearch(
              controller: controller.campoBuscarCliente,
              labelText: 'Buscar cliente',
              onChanged: (value) => _buscarCliente(value, controller),
            ),
            SizedBox(
              width: General.mediaQuery(context).width * 0.7,
              height: General.mediaQuery(context).height * 0.66,
              child: controller.listaClientes.value.isEmpty
                  ? const Center(child: Text('No hay clientes creados '))
                  : ListView.builder(
                      itemCount: controller.filtroClientes.value.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          onTap: () => _obtenerClienteSeleccionado(controller,
                              controller.filtroClientes.value[index], context),
                          title: Text(
                              "${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: const [CloseButtonCustom()],
    );
  }
}

void _buscarCliente(String value, CreditsController controller) {
  List<Client> results = [];
  if (value.isEmpty) {
    results = controller.listaClientes.value;
  } else {
    results = controller.listaClientes.value
        .where(
          (element) =>
              element.nombres!.toLowerCase().contains(value.toLowerCase()) ||
              element.apellidos!.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
  }
  controller.filtroClientes.value = results;
}

void _obtenerClienteSeleccionado(
    CreditsController controller, Client cliente, BuildContext context) {
  controller.nombreCliente.text =
      '${cliente.nombres!.split(' ').first} ${cliente.apellidos}';

  controller.idClienteSeleccionado = cliente.id;
  Navigator.pop(context);
  controller.campoBuscarCliente.clear();
}
