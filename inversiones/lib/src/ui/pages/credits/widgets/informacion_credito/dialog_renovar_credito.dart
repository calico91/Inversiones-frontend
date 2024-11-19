import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class DialogRenovarCredito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();

    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Text('Renovar credito', textAlign: TextAlign.center),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.48,
        child: Column(
          children: [
            Text('Cliente: ${controller.nombreClienteSeleccionado!}',
                textAlign: TextAlign.center),
            Text(
                'Saldo: ${General.formatoMoneda(controller.saldoCreditoSeleccionado)}'),
            Form(
              key: controller.formRenovacion,
              child: Column(
                children: [
                  Row(children: [
                    TextFieldBase(
                        paddingHorizontal: 10,
                        widthTextField: 0.31,
                        title: 'Valor credito',
                        controller:
                            controller.valorCreditoRenovacion.controller,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.creditValue),
                    Obx(() => TextFieldBase(
                        readOnly: true,
                        widthTextField: 0.31,
                        title: 'Valor a entregar',
                        controller: TextEditingController(
                            text: controller.valorEntregarResultado.value),
                        textInputType: TextInputType.number,
                        validateText: ValidateText.creditValue))
                  ]),
                  Row(children: [
                    TextFieldBase(
                        paddingHorizontal: 10,
                        widthTextField: 0.31,
                        title: 'Interes',
                        controller: controller.porcentajeInteres,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.interestPercentage),
                    TextFieldBase(
                        widthTextField: 0.31,
                        title: 'Cantidad cuotas',
                        controller: controller.cantidadCuotas,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.installmentAmount),
                  ]),
                  Row(children: [
                    TextFieldCalendar(
                        title: 'Fecha credito',
                        letterSize: 0.015,
                        paddingHorizontal: 10,
                        widthTextField: 0.31,
                        controller: controller.fechaCredito,
                        onTap: () async => controller.showCalendar(
                            context, controller.fechaCredito)),
                    TextFieldCalendar(
                        title: 'fecha cuota ',
                        letterSize: 0.015,
                        widthTextField: 0.31,
                        controller: controller.fechaCuota,
                        onTap: () async => controller.showCalendar(
                            context, controller.fechaCuota)),
                  ]),
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
                                  : Constantes.MODALIDAD_QUINCENAL)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: General.mediaQuery(context).width * 0.06),
                      FilledButton.icon(
                        icon: const Icon(Icons.monetization_on),
                        label: const Text("Registrar"),
                        onPressed: () {
                          if (General.validateForm(controller.formRenovacion)) {
                            controller.save(true);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [_cerrar(controller)],
    );
  }
}

Widget _cerrar(CreditsController controller) => IconButton(
    iconSize: 32,
    tooltip: 'Cerrar',
    onPressed: () => controller.limpiarFormularioRenovacion(),
    icon: const Icon(Icons.close_rounded),
    color: Colors.grey);
