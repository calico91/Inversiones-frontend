import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class FormularioRegistrarCliente extends StatelessWidget {
  const FormularioRegistrarCliente({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.put(ClientsController());

    return _formularioRegistrarCliente(context, controller);
  }

  Form _formularioRegistrarCliente(
          BuildContext context, ClientsController controller) =>
      Form(
        key: controller.formKey,
        child: CustomCard(
          child: SizedBox(
            height: General.mediaQuery(context).height * 0.55,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextFieldBase(
                        paddingHorizontal: 20,
                        hintText: 'Cedula',
                        controller: controller.document,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.document,
                      ),
                      TextFieldBase(
                        hintText: 'Celular',
                        controller: controller.phoneNumber,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.phoneNumber,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldBase(
                        hintText: 'Nombres',
                        textAlign: TextAlign.left,
                        paddingHorizontal: 20,
                        controller: controller.name,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                      TextFieldBase(
                        textAlign: TextAlign.left,
                        hintText: 'Apellidos',
                        controller: controller.lastname,
                        textInputType: TextInputType.multiline,
                        validateText: ValidateText.name,
                      ),
                    ],
                  ),
                  TextFieldBase(
                    textAlign: TextAlign.left,
                    paddingHorizontal: 20,
                    hintText: 'Direccion',
                    controller: controller.address,
                    textInputType: TextInputType.text,
                    validateText: ValidateText.name,
                    widthTextField: 0.83,
                  ),
                  TextFieldBase(
                    textAlign: TextAlign.left,
                    paddingHorizontal: 20,
                    required: false,
                    hintText: 'Observaciones',
                    expands: true,
                    controller: controller.observations,
                    textInputType: TextInputType.multiline,
                    validateText: ValidateText.observations,
                    widthTextField: 0.89,
                    heightTextField: 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _seleccionarImagenes(context, controller),
                      Obx(() => _botonRegistrarCliente(context, controller)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget _botonRegistrarCliente(
          BuildContext context, ClientsController controller) =>
      FilledButton.icon(
        onPressed: () {
          if (General.validateForm(controller.formKey)) {
            if (!controller.estaEditando.value) {
              controller.save();
            } else {
              controller.updateClient();
            }
          }
        },
        icon: !controller.estaEditando.value
            ? const Icon(Icons.person_add)
            : const Icon(Icons.refresh),
        label: !controller.estaEditando.value
            ? const Text("Registrar")
            : const Text("Actualizar"),
      );

  Widget limpiarFormulario(ClientsController controller) => IconButton(
        onPressed: () => controller.cleanForm(),
        icon: const Icon(Icons.delete_sweep_sharp),
        tooltip: "Limpiar Formulario",
      );

  Widget _seleccionarImagenes(
          BuildContext context, ClientsController controller) =>
      FilledButton.icon(
        
        label: const Text("Cargar imágenes"),
        icon: const FaIcon(FontAwesomeIcons.image, color: Colors.white),
        onPressed: () async {
          // si no ah seleccionado imagenes, se abre para que seleeccione
          if (controller.multiImagePickerController.value.images.isEmpty) {
            await controller.multiImagePickerController.value.pickImages();
          }
          // si abre el selector de imagenes pero no selecciona ninguna, no muestra este modal
          if (controller.multiImagePickerController.value.images.isNotEmpty) {
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: SizedBox(
                    height: General.mediaQuery(context).height * 0.6,
                    child: MultiImagePickerView(
                        initialWidget: const DefaultInitialWidget(
                            backgroundColor: Colors.white,
                            centerWidget: FaIcon(FontAwesomeIcons.circlePlus,
                                color: ColoresApp.azulPrimario, size: 30)),
                        controller: controller.multiImagePickerController.value,
                        padding: const EdgeInsets.all(10)),
                  ),
                );
              },
            );
          }
        },
      );
}
