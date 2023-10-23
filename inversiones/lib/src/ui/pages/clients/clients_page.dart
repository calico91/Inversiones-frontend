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
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextFieldBase(
                  paddingHorizontal: 20,
                  title: 'Cedula',
                  controller: controller.name,
                  textInputType: TextInputType.number,
                  validateText: ValidateText.onlyNumbers,
                ),
                TextFieldBase(
                  title: 'Celular',
                  controller: controller.name,
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
                  textInputType: TextInputType.text,
                  validateText: ValidateText.name,
                ),
                TextFieldBase(
                  title: 'Apellidos',
                  controller: controller.name,
                  textInputType: TextInputType.text,
                  validateText: ValidateText.name,
                ),
              ],
            ),
            TextFieldBase(
              paddingHorizontal: 20,
              title: 'Direccion',
              controller: controller.name,
              textInputType: TextInputType.text,
              validateText: ValidateText.name,
              widthTextField: 0.83,
            ),
            TextFieldBase(
              paddingHorizontal: 20,
              title: 'Observaciones',
              controller: controller.name,
              textInputType: TextInputType.multiline,
              validateText: ValidateText.observations,
              widthTextField: 0.83,
              heightTextField: 0.2,
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.monetization_on_outlined),
              label: const Text("Creditos"),
            ),
          ],
        ),
      ]),
    );
  }
}
