import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/labels/titulo_nombre_cliente.dart';
import 'package:screenshot/screenshot.dart';

class DialogInfoCreditoCreado extends StatelessWidget {
  final String title;
  final DataCreditResponse? info;
  final ScreenshotController screenshotController = ScreenshotController();
  final bool renovarCredito;
  final int diasMora;
  final String valorMora;

  DialogInfoCreditoCreado(
      {super.key,
      required this.title,
      this.info,
      required this.diasMora,
      required this.valorMora,
      required this.renovarCredito});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        child: Screenshot(
          controller: screenshotController,
          child: ColoredBox(
            color: Colors.white,
            child: CustomCard(
              child: Column(
                children: [
                  TituloNombreCliente(nombreCliente: info!.nombreCliente!),
                  _showInfoCredito('Modalidad', info!.modalidad!, context),
                  _showInfoCredito(
                      'Cantidad cuotas', info!.cantidadCuotas!, context),
                  _showInfoCredito('Fecha pago', info!.fechaPago!, context),
                  _showInfoCredito(
                      'Valor crédito',
                      General.formatoMoneda(double.parse(info!.valorCredito!)),
                      context),
                  _showInfoCredito(
                      'Valor cuotas',
                      General.formatoMoneda(double.parse(info!.valorCuotas!)),
                      context),
                  _showInfoCredito(
                      'Valor primer cuota',
                      General.formatoMoneda(
                          double.parse(info!.valorPrimerCuota!)),
                      context),
                  const Divider(color: Colors.black),
                  Text(
                      Constantes.INFORMACION_CREDITO_CREADO(
                          diasMora, valorMora),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        ShareButton(
          screenshotController: screenshotController,
          descripcion: 'Información crédito',
        ),
        const HomeButton(),
        if (!renovarCredito) const CloseButtonCustom()
      ],
    );
  }

  Widget _showInfoCredito(
    String title,
    String info,
    BuildContext context,
  ) {
    return Column(
      children: [
        SizedBox(
          height: General.mediaQuery(context).height * 0.003,
        ),
        Row(
          children: [
            Text('$title:', textAlign: TextAlign.left),
            Expanded(child: Container()),
            SizedBox(
              width: General.mediaQuery(context).width * 0.21,
              child: Text(
                maxLines: 2,
                info,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
