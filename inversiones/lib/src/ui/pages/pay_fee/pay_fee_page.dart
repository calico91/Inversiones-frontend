import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
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
                    context,
                    controller,
                  ),
                  icon: const Icon(Icons.money),
                  label: const Text("Pagar cuota"),
                ),
                FilledButton.icon(
                  onPressed: () {},
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
    BuildContext context,
    PayFeeController controller,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          textAlign: TextAlign.center,
          'Desea pagar la cuota?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.pagarCuota();
            } ,
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
