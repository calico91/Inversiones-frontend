import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class DialogCuotaPagada extends StatelessWidget {
  DialogCuotaPagada({required this.dataAbono});
  final DataAbono dataAbono;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    /// si no es un abono a capital muestra todos los campos
    final bool mostrarCampo = dataAbono.tipoAbono != Constantes.ABONO_CAPITAL;
    return AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        'Informacion abono',
      ),
      content: SizedBox(
        height: mostrarCampo
            ? General.mediaQuery(context).height * 0.17
            : General.mediaQuery(context).height * 0.12,
        child: Screenshot(
          controller: screenshotController,
          child: ColoredBox(
            color: Colors.white,
            child: CustomCard(
              child: Column(
                children: [
                  _mostrarContenido(
                    'Cuotas Pagadas:',
                    dataAbono.cuotasPagadas,
                    context,
                    mostrarCampo,
                  ),
                  _mostrarContenido(
                    'Cantidad de cuotas:',
                    dataAbono.cantidadCuotas,
                    context,
                    mostrarCampo,
                  ),
                  _mostrarContenido(
                    'Tipo abono:',
                    dataAbono.tipoAbono == Constantes.SOLO_INTERES
                        ? 'Interes'
                        : dataAbono.tipoAbono == Constantes.ABONO_CAPITAL
                            ? 'Abono capital'
                            : 'Cuota capital',
                    context,
                    true,
                  ),
                  _mostrarContenido(
                    'Valor abonado:',
                    General.formatoMoneda(
                      General.stringToDouble(dataAbono.valorAbonado),
                    ),
                    context,
                    true,
                  ),
                  _mostrarContenido(
                    'Fecha abono:',
                    General.formatoFecha(DateTime.now()),
                    context,
                    true,
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
          descripcion: 'Abono',
        ),
        HomeButton(),
      ],
    );
  }

  Widget _mostrarContenido(
    String label,
    String informacion,
    BuildContext context,
    bool mostrarCampo,
  ) {
    if (mostrarCampo) {
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
    } else {
      return const SizedBox();
    }
  }
}
