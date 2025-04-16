import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/button_actions.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/whatsapp_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_body.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/labels/informacion_fila.dart';
import 'package:inversiones/src/ui/pages/widgets/labels/titulo_nombre_cliente.dart';
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
        appBar: AppBarCustom('Cuota crédito', actions: [
          WhatsAppButton(
              celular: controller.payFee.celular!, color: Colors.white),
          ShareButton(
            screenshotController: screenshotController,
            descripcion: 'Informacion cuota',
            color: Colors.white,
          )
        ]),
        body: CustomCardBody(
          child: Column(children: [
            const SizedBox(height: 10),
            Screenshot(
                controller: screenshotController,
                child: CustomCard(
                    child: Obx(() => ColoredBox(
                        color: Colors.white,
                        child: Column(children: [
                          TituloNombreCliente(
                              fontSize: 20,
                              nombreCliente: controller.nombreCliente),
                          InformacionFila(
                              titulo: 'Fecha cuota',
                              informacion: controller.payFee.fechaCuota!),
                          InformacionFila(
                              titulo: 'Proxima Mora',
                              informacion: controller.payFee.fechaProximaMora!),
                          InformacionFila(
                              titulo: 'Cantidad cuotas',
                              informacion:
                                  controller.payFee.numeroCuotas!.toString()),
                          InformacionFila(
                              titulo: 'Cuota numero',
                              informacion:
                                  controller.payFee.cuotaNumero!.toString()),
                          InformacionFila(
                              titulo: 'Dias mora',
                              informacion:
                                  controller.payFee.diasMora.toString()),
                          InformacionFila(
                              titulo: 'Interes mora',
                              informacion: General.formatoMoneda(
                                  controller.payFee.interesMora)),
                          InformacionFila(
                              titulo: 'Valor interes',
                              informacion: General.formatoMoneda(
                                  controller.payFee.valorInteres)),
                          InformacionFila(
                              titulo: 'Valor capital',
                              informacion: General.formatoMoneda(
                                  controller.payFee.valorCapital)),
                          InformacionFila(
                              titulo: 'Valor cuota',
                              informacion: General.formatoMoneda(
                                  controller.payFee.valorCuota))
                        ]))))),

            ///botones
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ButtonActions(
                  onPressed: () => _mostrarConfirmacionPagoCuota(
                      General.mediaQuery(context),
                      'Desea pagar la cuota?',
                      context,
                      controller,
                      false),
                  height: 0.05,
                  width: 0.35,
                  label: 'Pagar cuota',
                  fontSize: 15),
              ButtonActions(
                  onPressed: () => _mostrarConfirmacionPagoCuota(
                      General.mediaQuery(context),
                      'Desea pagar solo interes?',
                      context,
                      controller,
                      true),
                  height: 0.05,
                  width: 0.35,
                  label: 'Pagar interes',
                  fontSize: 15),
            ])
          ]),
        ));
  }

  Future _mostrarConfirmacionPagoCuota(Size size, String mensaje,
      BuildContext context, PayFeeController controller, bool soloInteres) {
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
                        child: Column(children: [
                          Text(textAlign: TextAlign.center, mensaje),
                          const SizedBox(height: 20),
                          Form(
                              key: controller.formKey,
                              child: TextFieldBase(
                                  hintText: 'valor Interes',
                                  controller: controller.valorAbono,
                                  textInputType: TextInputType.number,
                                  validateText: ValidateText.creditValue))
                        ]))
                    : Obx(() => SizedBox(
                        height: controller.cambiarCuota.value
                            ? size.height * 0.2
                            : size.height * 0.08,
                        child: Column(children: [
                          Text(textAlign: TextAlign.center, mensaje),
                          Row(children: [
                            const Text(
                                textAlign: TextAlign.center, 'Modificar cuota'),
                            Switch(
                                value: controller.cambiarCuota.value,
                                activeColor: ColoresApp.azulPrimario,
                                onChanged: (bool value) =>
                                    controller.cambiarValorSwitch(value))
                          ]),
                          if (controller.cambiarCuota.value)
                            Form(
                                key: controller.formKey,
                                child: TextFieldBase(
                                    hintText: 'Valor cuota',
                                    controller: controller.valorAbono,
                                    textInputType: TextInputType.number,
                                    validateText: ValidateText.creditValue))
                          else
                            const SizedBox()
                        ]))),
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
                      }),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.cambiarCuota(false);
                      })
                ]));
  }
}
