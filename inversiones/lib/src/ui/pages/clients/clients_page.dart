import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Form(
                        key: controller.formKeyDocument,
                        child: TextFieldBase(
                          paddingHorizontal: 20,
                          title: 'Cedula',
                          controller: controller.document,
                          textInputType: TextInputType.number,
                          validateText: ValidateText.onlyNumbers,
                        ),
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                onPressed: () {
                  if (controller.validateForm()) {
                    controller.unfocus(context);
                    controller.save();
                  }
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Registrar"),
              ),
              Obx(
                () => FilledButton.icon(
                  onPressed: () {
                    if (controller.idClient == 0) {
                      if (controller.validateFormDocument()) {
                        controller.loadClient();
                      }
                    } else {
                      if (controller.validateForm()) {
                        controller.unfocus(context);
                        controller.updateClient();
                      }
                    }
                  },
                  icon: controller.idClient == 0
                      ? const Icon(Icons.find_in_page_rounded)
                      : const Icon(Icons.mode_edit_outline),
                  label: controller.idClient == 0
                      ? const Text("Consultar")
                      : const Text("Actualizar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
