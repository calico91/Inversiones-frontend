import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/clients/widgets/lista_clientes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class Clients extends StatelessWidget {
  const Clients({super.key});
  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.find<ClientsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Form(
              key: controller.formKey,
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
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: General.mediaQuery(context).width * 0.31,
                ),
                child: FilledButton.icon(
                  onPressed: () {
                    if (controller.validateForm()) {
                      if (controller.idClient.value == 0) {
                        controller.unfocus(context);
                        controller.save(General.mediaQuery(context));
                      } else {
                        controller.unfocus(context);
                        controller.updateClient(General.mediaQuery(context));
                      }
                    }
                  },
                  icon: controller.idClient.value == 0
                      ? const Icon(Icons.person_add)
                      : const Icon(Icons.mode_edit_outline),
                  label: controller.idClient.value == 0
                      ? const Text("Registrar")
                      : const Text("Actualizar"),
                ),
              ),
            ),
            const ListaClientes(),
          ],
        ),
      ),
    );
  }
}
