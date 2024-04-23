import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class DialogInfoCredito extends StatelessWidget {
  final String title;
  final DataCreditResponse? info;
  final ScreenshotController screenshotController = ScreenshotController();

  DialogInfoCredito({
    required this.title,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.12,
        child: Screenshot(
          controller: screenshotController,
          child: ColoredBox(
            color: Colors.white,
            child: CustomCard(
              child: Column(
                children: [
                  _showInfoCredito('Fecha pago', info!.fechaPago!),
                  _showInfoCredito(
                    'Valor credito',
                    General.formatoMoneda(
                      double.parse(info!.valorCredito!),
                    ),
                  ),
                  _showInfoCredito(
                    'Valor cuotas',
                    General.formatoMoneda(double.parse(info!.valorCuotas!)),
                  ),
                  _showInfoCredito(
                    'Cantidad cuotas',
                    info!.cantidadCuotas!,
                  ),
                  _showInfoCredito(
                    'Valor primer cuota',
                    General.formatoMoneda(
                      double.parse(info!.valorPrimerCuota!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        ShareButton(
          screenshotController: screenshotController,
          descripcion: Constantes.INFORMACION_CREDITO_CREADO,
        ),
        HomeButton(),
        CloseButtonCustom()
      ],
    );
  }

  Widget _showInfoCredito(
    String title,
    String info,
  ) {
    return Row(
      children: [
        Text('$title:', textAlign: TextAlign.left),
        Expanded(child: Container()),
        Text(
          info,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
