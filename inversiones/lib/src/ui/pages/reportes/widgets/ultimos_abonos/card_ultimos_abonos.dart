import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_small.dart';

class CardUltimosAbonos extends StatelessWidget {
  const CardUltimosAbonos(this.controller);

  final ReportesController controller;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Informacion ultimos abonos',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: General.mediaQuery(context).height* 0.09,
                width: 50,
                child: Form(
                  key: controller.formKey,
                  child: TextFieldSmall(
                    validateText: ValidateText.installmentAmount,
                    controller: controller.cantidadAbonosConsultar,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Consultar ultimos abonos',
                onPressed: () {
                  if (General.validateForm(controller.formKey)) {
                    controller
                        .consultarUltimosAbonos(General.mediaQuery(context));
                  }
                },
                icon: const Icon(
                  Icons.info,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Obx(
            () => controller.ultimosAbonos.value.isNotEmpty
                ? SizedBox(
                    height: General.mediaQuery(context).height * 0.56,
                    child: ListView.builder(
                      itemCount: controller.ultimosAbonos.value.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                '${controller.ultimosAbonos.value[index].nombres!} ${controller.ultimosAbonos.value[index].apellidos!}',
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Valor abonado: ${General.formatoMoneda(controller.ultimosAbonos.value[index].valorAbonado)}',
                                ),
                                Text(
                                  'Fecha de pago: ${controller.ultimosAbonos.value[index].fechaAbono!}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
