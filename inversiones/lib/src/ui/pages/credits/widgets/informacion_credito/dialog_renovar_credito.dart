import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class DialogRenovarCredito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();

    return AlertDialog(
      title: const Text('Renovar credito', textAlign: TextAlign.center),
      content: Column(
        children: [
          Text('Cliente: ${controller.nombreClienteSeleccionado!}'),
          Text(
              'Saldo: ${General.formatoMoneda(controller.saldoCreditoSeleccionado)}'),
          Row(
            children: [
              TextFieldBase(
                  paddingHorizontal: 10,
                  widthTextField: 0.32,
                  title: 'Valor credito',
                  controller: controller.valorCredito,
                  textInputType: TextInputType.number,
                  validateText: ValidateText.creditValue),
              TextFieldBase(
                  widthTextField: 0.32,
                  title: 'Valor a entregar',
                  controller: controller.valorAEntregar,
                  textInputType: TextInputType.number,
                  validateText: ValidateText.creditValue),
            ],
          ),
        ],
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
