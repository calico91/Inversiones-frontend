import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class FormularioCredito extends StatelessWidget {
  const FormularioCredito({super.key});

  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.put(CreditsController());

    return CustomCard(
      child: Form(
        key: controller.formKey,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextFieldBase(
                      paddingHorizontal: 20,
                      hintText: 'Valor crédito',
                      controller: controller.valorCredito,
                      textInputType: TextInputType.number,
                      validateText: ValidateText.creditValue),
                  TextFieldBase(
                      hintText: 'Interes',
                      controller: controller.porcentajeInteres,
                      textInputType: TextInputType.number,
                      validateText: ValidateText.interestPercentage),
                ],
              ),
              Row(
                children: [
                  TextFieldBase(
                      paddingHorizontal: 20,
                      hintText: 'Cantidad cuotas',
                      controller: controller.cantidadCuotas,
                      textInputType: TextInputType.number,
                      validateText: ValidateText.installmentAmount),
                  InkWell(
                    onTap: () => controller.consultarClientes(),
                    child: TextFieldBase(
                        enabled: false,
                        hintText: 'Seleccione cliente',
                        controller: controller.nombreCliente,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.name),
                  ),
                ],
              ),
              Row(
                children: [
                  TextFieldCalendar(
                      paddingHorizontal: 20,
                      controller: controller.fechaCredito,
                      onTap: () async => controller.showCalendar(
                          context, controller.fechaCredito),
                      title: 'Fecha crédito'),
                  TextFieldCalendar(
                      controller: controller.fechaCuota,
                      onTap: () async => controller.showCalendar(
                          context, controller.fechaCuota),
                      title: 'Fecha cuota'),
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
                                  controller.cambiarModalidad(value)),
                          Text(controller.modalidad.value
                              ? Constantes.MODALIDAD_MENSUAL
                              : Constantes.MODALIDAD_QUINCENAL),
                        ],
                      ),
                    ),
                  ),

                  /// boton registrar
                  FilledButton.icon(
                    icon: const Icon(Icons.monetization_on),
                    label: const Text("Registrar"),
                    onPressed: () {
                      if (General.validateForm(controller.formKey)) {
                        controller.save(false);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
