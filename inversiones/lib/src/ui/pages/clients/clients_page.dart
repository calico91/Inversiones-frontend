import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/clients/widgets/lista_clientes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.put(ClientsController());
    print("render");
    controller.asignartituloBotonRegistrarActualizarCliente();

    return Scaffold(
      appBar: const AppBarCustom('Clientes'),
      body: ListView(
        addRepaintBoundaries: false,
        children: [
          _formularioRegistrarCliente(context, controller),
          const ListaClientes(),
        ],
      ),
    );
  }

  Form _formularioRegistrarCliente(
          BuildContext context, ClientsController controller) =>
      Form(
        key: controller.formKey,
        child: CustomCard(
          child: SizedBox(
            height: General.mediaQuery(context).height * 0.4,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextFieldBase(
                        paddingHorizontal: 20,
                        title: 'Cedula',
                        controller: controller.document,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                      TextFieldBase(
                        title: 'Celular',
                        controller: controller.phoneNumber,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.phoneNumber,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldBase(
                        textAlign: TextAlign.left,
                        paddingHorizontal: 20,
                        title: 'Nombres',
                        controller: controller.name,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                      TextFieldBase(
                        textAlign: TextAlign.left,
                        title: 'Apellidos',
                        controller: controller.lastname,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                    ],
                  ),
                  TextFieldBase(
                    textAlign: TextAlign.left,
                    paddingHorizontal: 20,
                    title: 'Direccion',
                    controller: controller.address,
                    textInputType: TextInputType.text,
                    validateText: ValidateText.name,
                    widthTextField: 0.83,
                  ),
                  TextFieldBase(
                    textAlign: TextAlign.left,
                    paddingHorizontal: 20,
                    required: false,
                    title: 'Observaciones',
                    controller: controller.observations,
                    textInputType: TextInputType.multiline,
                    validateText: ValidateText.observations,
                    widthTextField: 0.83,
                    heightTextField: 0.13,
                  ),
                  Obx(() => _botonRegistrarCliente(context, controller))
                ],
              ),
            ),
          ),
        ),
      );

  Widget _botonRegistrarCliente(
          BuildContext context, ClientsController controller) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: General.mediaQuery(context).width * 0.3,
        ),
        child: FilledButton.icon(
          onPressed: () {
            if (General.validateForm(controller.formKey)) {
              if (controller.registrarCliente.value) {
                print("guardar");
                controller.save();
                controller.unfocus(context);
              } else {
                print("actu");
                controller.unfocus(context);
                controller.updateClient();
              }
            }
          },
          icon: controller.registrarCliente.value
              ? const Icon(Icons.person_add)
              : const Icon(Icons.mode_edit_outline),
          label: controller.registrarCliente.value
              ? const Text("Registrar")
              : const Text("Actualizar"),
        ),
      );
}
