import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

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
                tooltip: 'Consultar',
                onPressed: () {
                  if (General.validateForm(controller.formKey)) {
                    controller.consultarUltimosAbonos();
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
          Form(
            key: controller.formKey,
            child: TextFieldBase(
              title: 'Cantidad de abonos',
              textInputType: TextInputType.number,
              validateText: ValidateText.installmentAmount,
              controller: controller.cantidadAbonosConsultar,
            ),
          ),
        ],
      ),
    );
  }
}
