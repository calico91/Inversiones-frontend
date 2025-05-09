import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class DialogRenovarCredito extends StatelessWidget {
  const DialogRenovarCredito({super.key});

  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();

    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Text('Renovar crédito', textAlign: TextAlign.center),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.48,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Cliente: ${controller.nombreClienteSeleccionado!}',
                  textAlign: TextAlign.center),
              Text(
                  'Saldo: ${General.formatoMoneda(controller.saldoCreditoSeleccionado)}'),
              Form(
                key: controller.formRenovacion,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(children: [
                        TextFieldBase(
                            paddingHorizontal: 10,
                            widthTextField: 0.31,
                            hintText: 'Valor crédito',
                            controller:
                                controller.valorCreditoRenovacion.controller,
                            textInputType: TextInputType.number,
                            validateText: ValidateText.creditValue),
                        Obx(() => TextFieldBase(
                            readOnly: true,
                            widthTextField: 0.31,
                            hintText: 'Valor a entregar',
                            controller: TextEditingController(
                                text: controller.valorEntregarResultado.value),
                            textInputType: TextInputType.number,
                            validateText: ValidateText.creditValue))
                      ]),
                      Row(children: [
                        TextFieldBase(
                            paddingHorizontal: 10,
                            widthTextField: 0.31,
                            hintText: 'Interes',
                            controller: controller.porcentajeInteres,
                            textInputType: TextInputType.number,
                            validateText: ValidateText.interestPercentage),
                        TextFieldBase(
                            widthTextField: 0.31,
                            hintText: 'Cantidad cuotas',
                            controller: controller.cantidadCuotas,
                            textInputType: TextInputType.number,
                            validateText: ValidateText.installmentAmount),
                      ]),
                      Row(children: [
                        TextFieldCalendar(
                            title: 'Fecha crédito',
                            letterSize: 0.013,
                            paddingHorizontal: 10,
                            widthTextField: 0.31,
                            controller: controller.fechaCredito,
                            onTap: () async => controller.showCalendar(
                                context, controller.fechaCredito)),
                        TextFieldCalendar(
                            title: 'fecha cuota ',
                            letterSize: 0.013,
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
                                      activeTrackColor: ColoresApp.azulPrimario,
                                      inactiveTrackColor: ColoresApp.azulPrimario,
                                      inactiveThumbColor: ColoresApp.azulPrimario,
                                      onChanged: (bool value) =>
                                          controller.cambiarModalidad(value)),
                                  Text(controller.modalidad.value
                                      ? Constantes.MODALIDAD_MENSUAL
                                      : Constantes.MODALIDAD_QUINCENAL)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              width: General.mediaQuery(context).width * 0.06),
                          FilledButton.icon(
                            icon: const Icon(Icons.monetization_on),
                            label: const Text("Registrar"),
                            onPressed: () {
                              if (General.validateForm(
                                  controller.formRenovacion)) {
                                controller.save(true);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
