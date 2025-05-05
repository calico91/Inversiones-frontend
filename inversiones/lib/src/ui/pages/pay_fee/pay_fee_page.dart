import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
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
                              titulo: 'Id credito',
                              informacion: controller
                                  .homeController.idCredito.value
                                  .toString()),
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
                  onPressed: () =>
                      _mostrarConfirmacionPagoCuota(context, controller, false),
                  height: 0.05,
                  width: 0.35,
                  label: 'Pagar cuota',
                  fontSize: 15),
              ButtonActions(
                  onPressed: () =>
                      _mostrarConfirmacionPagoCuota(context, controller, true),
                  height: 0.05,
                  width: 0.35,
                  label: 'Pagar interes',
                  fontSize: 15),
            ])
          ]),
        ));
  }

  Future _mostrarConfirmacionPagoCuota(
      BuildContext context, PayFeeController controller, bool soloInteres) {
    controller.valorAbono.text = (soloInteres
            ? controller.payFee.valorInteres
            : controller.payFee.valorCuota)
        .toString()
        .split('.')
        .first;

    final String mensaje = soloInteres
        ? '¿Desea pagar solo interes?'
        : '¿Desea pagar la cuota normal?';

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                scrollable: true,
                actionsPadding: EdgeInsets.zero,
                content: SizedBox(
                    height: General.mediaQuery(context).height * 0.17,
                    child: Column(children: [
                      Text(textAlign: TextAlign.center, mensaje),
                      const SizedBox(height: 20),
                      Form(
                          key: controller.formKey,
                          child: TextFieldBase(
                              hintText:
                                  soloInteres ? 'valor Interes' : 'Valor cuota',
                              controller: controller.valorAbono,
                              textInputType: TextInputType.number,
                              validateText: ValidateText.creditValue))
                    ])),
                actions: [
                  TextButton(
                      child: const Text('Si'),
                      onPressed: () {
                        if (General.validateForm(controller.formKey)) {
                          controller.pagarCuota(soloInteres
                              ? Constantes.SOLO_INTERES
                              : Constantes.CUOTA_NORMAL);
                          Navigator.pop(context);
                        }
                      }),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]));
  }
}
