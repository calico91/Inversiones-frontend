import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/clients/widgets/formulario_registro_clientes.dart';
import 'package:inversiones/src/ui/pages/clients/widgets/lista_clientes.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom('Clientes', actions: [_limpiarFormulario()]),
        body: ListView(
            addRepaintBoundaries: false,
            children: const [FormularioRegistrarCliente(), ListaClientes()]));
  }

  Widget _limpiarFormulario() => IconButton(
      onPressed: () => Get.put(ClientsController()).cleanForm(),
      icon: const Icon(Icons.delete_sweep_sharp),
      tooltip: "Limpiar Formulario");
}
