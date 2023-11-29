import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class DialogCuotaPagada extends StatelessWidget {
  DialogCuotaPagada({this.dataAbono});
  final DataAbono? dataAbono;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        textAlign: TextAlign.center,
        dataAbono?.estadoCuota ?? 'Abono realizado correctamente',
      ),
      content: SizedBox(
        height: dataAbono != null
            ? General.mediaQuery(context).height * 0.17
            : General.mediaQuery(context).height * 0.00,
        child: dataAbono != null
            ? Screenshot(
                controller: screenshotController,
                child: ColoredBox(
                  color: Colors.white,
                  child: CustomCard(
                    child: Column(
                      children: [
                        _mostrarContenido(
                          'Cuotas Pagadas:',
                          dataAbono!.cuotasPagadas,
                          context,
                        ),
                        _mostrarContenido(
                          'Cantidad de cuotas:',
                          dataAbono!.cantidadCuotas,
                          context,
                        ),
                        _mostrarContenido(
                          'Tipo abono:',
                          dataAbono!.tipoAbono == Constantes.SOLO_INTERES
                              ? 'Interes'
                              : 'Cuota capital',
                          context,
                        ),
                        _mostrarContenido(
                          'Valor abonado:',
                          General.formatoMoneda(
                            General.stringToDouble(dataAbono!.valorAbonado),
                          ),
                          context,
                        ),
                        _mostrarContenido(
                          'Fecha abono:',
                          General.formatoFecha(DateTime.now()),
                          context,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ),
      actions: [
        if (dataAbono != null)
          ShareButton(
            screenshotController: screenshotController,
            nombreArchivo: 'Abono',
          )
        else
          const SizedBox(),
        HomeButton(),
      ],
    );
  }

  Widget _mostrarContenido(
    String label,
    String informacion,
    BuildContext context,
  ) {
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
