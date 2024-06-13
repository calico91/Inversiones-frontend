import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class DialogFechaCuotaModificada extends StatelessWidget {
  DialogFechaCuotaModificada({required this.data});
  final PayFee data;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        title: Text(
          textAlign: TextAlign.center,
          Constantes.INFORMACION_CREDITO,
        ),
        content: Screenshot(
            controller: screenshotController,
            child: ColoredBox(
              color: Colors.white,
              child: CustomCard(
                child: SizedBox(
                  height: General.mediaQuery(context).height * 0.09,
                  child: Column(
                    children: [
                      _mostrarContenido(
                          'fecha Cuota:', data.fechaCuota!, context),
                      _mostrarContenido('Valor interes:',
                          General.formatoMoneda(data.valorInteres), context),
                      _mostrarContenido('Valor cuota:',
                          General.formatoMoneda(data.valorCuota), context),
                    ],
                  ),
                ),
              ),
            )),
        actions: [
          ShareButton(
            screenshotController: screenshotController,
            descripcion: 'Modificacion fecha pago',
          ),
          HomeButton(),
          CloseButtonCustom()
        ]);
  }

  Widget _mostrarContenido(
      String label, String informacion, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: General.mediaQuery(context).height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textAlign: TextAlign.center,
            label,
          ),
          Text(
            textAlign: TextAlign.center,
            informacion,
          ),
        ],
      ),
    );
  }
}
