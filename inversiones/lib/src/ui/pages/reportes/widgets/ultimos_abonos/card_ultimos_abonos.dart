import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';

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
              IconButton(
                tooltip: 'Consultar ultimos abonos',
                onPressed: () => controller.consultarUltimosAbonos(
                  General.mediaQuery(context),
                ),
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
                ? ListView.builder(
                    shrinkWrap: true,
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
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
