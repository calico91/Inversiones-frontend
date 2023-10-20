import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';

class SimulateCreditMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Column(
      children: [
        const Text(
          "Simular credito",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                maxLength: 7,
                controller: controller.amount,
                decoration: const InputDecoration(
                  hintText: 'Cantidad',
                ),
              ),
              TextFormField(
                maxLength: 2,
                controller: controller.dues,
                decoration: const InputDecoration(
                  hintText: 'Cuotas',
                ),
              ),
              TextFormField(
                maxLength: 1,
                controller: controller.interestPercentage,
                decoration: const InputDecoration(
                  hintText: 'Porcentaje interes',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () {
                  _showCreditInstallments(context);
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
              title: Text('Credito simulado'),
              content: Text("la cantidad de cuotas que debe pagar son lleve"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('ok'))
              ],
            ));
  }
}
