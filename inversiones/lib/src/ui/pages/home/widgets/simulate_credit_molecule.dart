import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class SimulateCreditMolecule extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "SIMULAR CREDITO",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFieldBase(
                title: 'Valor credito',
                textInputType: TextInputType.number,
                validateText: ValidateText.creditValue,
                controller: controller.creditValue,
              ),
              TextFieldBase(
                title: 'Cantidad cuotas',
                textInputType: TextInputType.number,
                validateText: ValidateText.installmentAmount,
                controller: controller.installmentAmount,
              ),
              TextFieldBase(
                title: 'Interes',
                textInputType: TextInputType.number,
                validateText: ValidateText.interestPercentage,
                controller: controller.interestPercentage,
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    _showCreditInstallments(context);
                  }
                },
                child: const Text('Calcular'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///modal que muestra la simulacion del credito
  Future _showCreditInstallments(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Credito simulado',
                textAlign: TextAlign.center,
              ),
              content: Text(
                '${controller.installmentAmount.text} cuotas de \$${controller.calculateCreditFee()}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                )
              ],
            ));
  }
}
