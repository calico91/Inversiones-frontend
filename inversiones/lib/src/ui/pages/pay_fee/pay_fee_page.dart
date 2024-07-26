import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar_style/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';
import 'package:screenshot/screenshot.dart';

class PayFeePage extends StatelessWidget {
  PayFeePage({super.key, this.idCliente = 0});
  final int idCliente;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final PayFeeController controller = Get.find<PayFeeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom('Cuota credito',centrarTitulo: 0.22),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: General.mediaQuery(context).height * 0.03,
          horizontal: General.mediaQuery(context).width * 0.1,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: General.mediaQuery(context).width * 0.5,
                  child: Text(controller.nombreCliente,
                      style: const TextStyle(
                          fontSize: 20, overflow: TextOverflow.ellipsis),
                      maxLines: 2),
                ),
                ShareButton(
                  screenshotController: screenshotController,
                  descripcion: 'Informacion cuota ${controller.nombreCliente}',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Screenshot(
              controller: screenshotController,
              child: CustomCard(
                child: Obx(() {
                  if (controller.loading) {
                    return const Loading(
                        circularLoading: false,
                        horizontal: 0.001,
                        vertical: 0.16);
                  }
                  return ColoredBox(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Fecha cuota',
                          controller.payFee.fechaCuota!,
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Proxima Mora',
                          controller.payFee.fechaProximaMora!,
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Cantidad cuotas',
                          controller.payFee.numeroCuotas!.toString(),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Cuota numero',
                          controller.payFee.cuotaNumero!.toString(),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Dias mora',
                          controller.payFee.diasMora.toString(),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Interes mora',
                          General.formatoMoneda(
                            controller.payFee.interesMora,
                          ),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Valor interes',
                          General.formatoMoneda(
                            controller.payFee.valorInteres,
                          ),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Valor capital',
                          General.formatoMoneda(
                            controller.payFee.valorCapital,
                          ),
                        ),
                        _infoValorCuota(
                          General.mediaQuery(context),
                          'Valor cuota',
                          General.formatoMoneda(
                            controller.payFee.valorCuota,
                          ),
                        ),
                      ],
                    ),
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
                    General.mediaQuery(context),
                    'Desea pagar la cuota?',
                    context,
                    controller,
                    false,
                  ),
                  icon: const Icon(Icons.money),
                  label: const Text("Pagar cuota"),
                ),
                FilledButton.icon(
                  onPressed: () => _mostrarConfirmacionPagoCuota(
                    General.mediaQuery(context),
                    'Desea pagar solo interes?',
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
        vertical: size.height * 0.01,
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
    soloInteres
        ? controller.valorAbono.text =
            controller.payFee.valorInteres.toString().split(".").first
        : controller.valorAbono.text = '';

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
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
                        controller: controller.valorAbono,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.creditValue,
                      ),
                    ),
                  ],
                ),
              )
            : Obx(
                () => SizedBox(
                  height: controller.cambiarCuota.value
                      ? size.height * 0.2
                      : size.height * 0.08,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        mensaje,
                      ),
                      Row(
                        children: [
                          const Text(
                            textAlign: TextAlign.center,
                            'Modificar cuota',
                          ),
                          Switch(
                            value: controller.cambiarCuota.value,
                            activeColor: Colors.blue,
                            onChanged: (bool value) =>
                                controller.cambiarValorSwitch(value),
                          ),
                        ],
                      ),
                      if (controller.cambiarCuota.value)
                        Form(
                          key: controller.formKey,
                          child: TextFieldBase(
                            title: 'Valor cuota',
                            controller: controller.valorAbono,
                            textInputType: TextInputType.number,
                            validateText: ValidateText.creditValue,
                          ),
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                ),
              ),
        actions: [
          TextButton(
            child: const Text('Si'),
            onPressed: () {
              if (!soloInteres) {
                if (controller.cambiarCuota.value) {
                  if (General.validateForm(controller.formKey)) {
                    controller.pagarCuota(Constantes.CUOTA_NORMAL);
                    Navigator.pop(context);
                    return;
                  }
                } else {
                  controller.pagarCuota(Constantes.CUOTA_NORMAL);
                  Navigator.pop(context);
                  return;
                }
              } else {
                if (General.validateForm(controller.formKey)) {
                  controller.pagarCuota(Constantes.SOLO_INTERES);
                  Navigator.pop(context);
                }
              }
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
              controller.cambiarCuota(false);
            },
          ),
        ],
      ),
    );
  }
}
