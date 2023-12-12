import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/lista_creditos_activos.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos'),
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
                      TextFieldBase(
                        paddingHorizontal: 20,
                        title: 'Valor credito',
                        controller: controller.creditValue,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.creditValue,
                      ),
                      TextFieldBase(
                        title: 'Interes',
                        controller: controller.interestPercentage,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.interestPercentage,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldBase(
                        paddingHorizontal: 20,
                        title: 'Cantidad cuotas',
                        controller: controller.installmentAmount,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.installmentAmount,
                      ),
                      TextFieldBase(
                        title: 'Documento cliente',
                        controller: controller.document,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldCalendar(
                        paddingHorizontal: 20,
                        controller: controller.creditDate,
                        onTap: () async => controller.showCalendar(
                          context,
                          controller.creditDate,
                        ),
                        title: 'Fecha credito',
                      ),
                      TextFieldCalendar(
                        controller: controller.installmentDate,
                        onTap: () async => controller.showCalendar(
                          context,
                          controller.installmentDate,
                        ),
                        title: 'Couta credito',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: General.mediaQuery(context).width * 0.18,
                          child: Column(
                            children: [
                              Switch(
                                value: controller.modalidad.value,
                                activeTrackColor: Colors.blue,
                                inactiveTrackColor: Colors.blue,
                                inactiveThumbColor: Colors.blue,
                                onChanged: (bool value) =>
                                    controller.cambiarModalidad(value),
                              ),
                              Text(
                                controller.modalidad.value
                                    ? Constantes.MODALIDAD_MENSUAL
                                    : Constantes.MODALIDAD_QUINCENAL,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// boton registrar
                      FilledButton.icon(
                        icon: const Icon(Icons.monetization_on),
                        label: const Text("Registrar"),
                        onPressed: () {
                          if (controller.validateForm()) {
                            controller.save(General.mediaQuery(context));
                          }
                        },
                      ),
                    ],
                  ),
                  const ListaCreditosActivos(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
