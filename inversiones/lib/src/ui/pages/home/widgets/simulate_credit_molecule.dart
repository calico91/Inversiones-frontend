import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';

class SimulateCreditMolecule extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

   SimulateCreditMolecule({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Simular crédito',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: General.mediaQuery(context).height * 0.03,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  tooltip: 'Calcular',
                  icon: const Icon(size: 25, Icons.info, color: Colors.blue),
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      _showCreditInstallments(context, controller);
                    }
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFieldBase(
                      title: 'Interes',
                      textInputType: TextInputType.number,
                      validateText: ValidateText.interestPercentage,
                      controller: controller.interestPercentage,
                    ),
                    SizedBox(
                      width: General.mediaQuery(context).width * 0.39,
                      child: Obx(
                        () => Column(
                          children: [
                            Switch(
                                value: controller.esMensual.value,
                                activeTrackColor: Colors.blue,
                                inactiveTrackColor: Colors.blue,
                                inactiveThumbColor: Colors.blue,
                                onChanged: (bool value) =>
                                    controller.cambiarModalidad(value)),
                            Text(controller.esMensual.value
                                ? Constantes.MODALIDAD_MENSUAL
                                : Constantes.MODALIDAD_QUINCENAL),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///modal que muestra la simulacion del credito
  Future _showCreditInstallments(
      BuildContext context, HomeController controller) {
    final String modalidad = controller.esMensual.value ? 'Mensuales' : 'Quincenales';
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        title: const Text(
          'Credito simulado',
          textAlign: TextAlign.center,
        ),
        content: Text(
          '${controller.installmentAmount.text} cuotas $modalidad de  ${controller.calculateCreditFee()}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
