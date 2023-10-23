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
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                        paddingHorizontal: 20,
                        title: 'Nombres',
                        controller: controller.name,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                      TextFieldBase(
                        title: 'Apellidos',
                        controller: controller.lastname,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                    ],
                  ),
                  TextFieldBase(
                    paddingHorizontal: 20,
                    title: 'Direccion',
                    controller: controller.address,
                    textInputType: TextInputType.text,
                    validateText: ValidateText.name,
                    widthTextField: 0.83,
                  ),
                  TextFieldBase(
                    paddingHorizontal: 20,
                    required: false,
                    title: 'Observaciones',
                    controller: controller.observations,
                    textInputType: TextInputType.multiline,
                    validateText: ValidateText.observations,
                    widthTextField: 0.83,
                    heightTextField: 0.2,
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
                  if (controller.formKeyDocument.currentState!.validate() &&
                      controller.formKey.currentState!.validate()) {}
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Registrar"),
              ),
              FilledButton.icon(
                onPressed: () {
                  if (controller.formKeyDocument.currentState!.validate()) {}
                },
                icon: const Icon(Icons.find_in_page_rounded),
                label: const Text("Consultar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
