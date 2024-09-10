import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/saldar_credito_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class DialogSaldarCredito extends StatelessWidget {
  DialogSaldarCredito({required this.data});
  final SaldarCreditoResponse data;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        actionsPadding: EdgeInsets.zero,
        title: Text(
          textAlign: TextAlign.center,
          Constantes.CREDITO_SALDADO,
        ),
        content: Screenshot(
            controller: screenshotController,
            child: ColoredBox(
              color: Colors.white,
              child: CustomCard(
                child: SizedBox(
                  height: General.mediaQuery(context).height * 0.14,
                  child: Column(
                    children: [
                      _mostrarContenido('Codigo credito:',
                          data.idCredito.toString(), context),
                      _mostrarContenido(
                          'Nombre cliente:', data.nombreCliente, context),
                      _mostrarContenido('Valor pagado:',
                          General.formatoMoneda(data.valorPagado), context),
                      _mostrarContenido('Valor credito:',
                          General.formatoMoneda(data.valorCredito), context),
                    ],
                  ),
                ),
              ),
            )),
        actions: [
          ShareButton(
            screenshotController: screenshotController,
            descripcion: 'Credito saldado',
          ),
          HomeButton()
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
          SizedBox(
            width: General.mediaQuery(context).width * 0.3,
            child: Text(
              maxLines: 2,
              textAlign: TextAlign.right,
              informacion,
            ),
          ),
        ],
      ),
    );
  }
}
