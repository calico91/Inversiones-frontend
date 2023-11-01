import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class PayFeePage extends StatelessWidget {
  const PayFeePage({super.key, this.idCliente = 0});
  final int idCliente;

  @override
  Widget build(BuildContext context) {
    final PayFeeController controller = Get.find<PayFeeController>();

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cuota credito'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
          horizontal: size.width * 0.1,
        ),
        child: Column(
          children: [
            Text(
              controller.nombreCliente,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 8,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.01,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.335,
                child: Obx(() {
                  if (controller.loading) {
                    return Loading(
                      horizontal: size.width * 0.00008,
                      vertical: size.height * 0.165,
                    ).linearLoading();
                  }
                  return Column(
                    children: [
                      _infoValorCuota(
                        size,
                        'Cantidad cuotas',
                        controller.payFee.numeroCuotas!.toString(),
                      ),
                      _infoValorCuota(
                        size,
                        'Numero cuota',
                        controller.payFee.cuotaNumero!.toString(),
                      ),
                      _infoValorCuota(
                        size,
                        'Fecha cuota',
                        controller.payFee.fechaCuota!,
                      ),
                      _infoValorCuota(
                        size,
                        'Valor cuota',
                        General.formatoMoneda(controller.payFee.valorCuota),
                      ),
                      _infoValorCuota(
                        size,
                        'Valor credito',
                        General.formatoMoneda(controller.payFee.valorCredito),
                      ),
                    ],
                  );
                }),
              ),
            ),

            ///botones
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton.icon(
                  onPressed: () => _mostrarConfirmacionPagoCuota(
                    size,
                    'Desea cancelar la cuota?',
                    context,
                    controller,
                    false,
                  ),
                  icon: const Icon(Icons.money),
                  label: const Text("Pagar cuota"),
                ),
                FilledButton.icon(
                  onPressed: () => _mostrarConfirmacionPagoCuota(
                    size,
                    'Desea cancelar solo interes?',
                    context,
                    controller,
                    true,
                  ),
                  icon: const Icon(Icons.monetization_on_outlined),
                  label: const Text("Pagar interes"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoValorCuota(
    Size size,
    String titulo,
    String info,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.01,
      ),
      child: Row(
        children: [
          Text(
            '$titulo:',
            style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          Expanded(child: Container()),
          Text(
            info,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future _mostrarConfirmacionPagoCuota(
    Size size,
    String mensaje,
    BuildContext context,
    PayFeeController controller,
    bool soloInteres,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: soloInteres
            ? SizedBox(
                height: size.height * 0.17,
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      mensaje,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: controller.formKey,
                      child: TextFieldBase(
                        title: 'valor Interes',
                        controller: controller.interestPercentage,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.creditValue,
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                textAlign: TextAlign.center,
                mensaje,
              ),
        actions: [
          TextButton(
            onPressed: () {
              if (!soloInteres) {
                controller.pagarCuota(false);
                Navigator.pop(context);
              } else {
                if (controller.validateForm()) {
                  controller.pagarCuota(true);
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Si'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
