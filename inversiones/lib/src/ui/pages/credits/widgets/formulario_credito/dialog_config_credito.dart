import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class DialogConfigCredito extends StatelessWidget {
  const DialogConfigCredito({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: "Configurar mora",
      onPressed: () => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final CreditsController controller = Get.put(CreditsController());
          return FutureBuilder(
            future: controller.obtenerMora(),
            builder: (context, _) {
              return AlertDialog(
                scrollable: true,
                actionsPadding: EdgeInsets.zero,
                title:
                    const Text('Configurar mora', textAlign: TextAlign.center),
                content: Form(
                  key: controller.formKeyMora,
                  child: Column(
                    children: [
                      CustomCard(
                        child: Row(children: [
                          TextFieldBase(
                              paddingHorizontal: 10,
                              widthTextField: 0.26,
                              title: 'Dias',
                              controller: controller.diasMora,
                              textInputType: TextInputType.number,
                              validateText: ValidateText.interestPercentage),
                          TextFieldBase(
                              widthTextField: 0.26,
                              title: 'Valor',
                              controller: controller.valorMora,
                              textInputType: TextInputType.number,
                              validateText: ValidateText.creditValue),
                        ]),
                      ),
                    ],
                  ),
                ),
                actions: [
                  _guardar(controller),
                  const CloseButtonCustom(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _guardar(CreditsController controller) => IconButton(
      icon: const Icon(Icons.save),
      color: Colors.blue,
      tooltip: 'Guardar',
      onPressed: () => controller.guardarValoresMora());
}
