import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:screenshot/screenshot.dart';

class DialogCuotaPagada extends StatelessWidget {
  DialogCuotaPagada({required this.accion, this.dataAbono});
  final VoidCallback accion;
  final DataAbono? dataAbono;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: AlertDialog(
        title: Text(
          textAlign: TextAlign.center,
          dataAbono?.estadoCuota ?? 'Abono realizado correctamente',
        ),
        content: SizedBox(
          height: dataAbono != null
              ? General.mediaQuery(context).height * 0.07
              : General.mediaQuery(context).height * 0.00,
          child: dataAbono != null
              ? Column(
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
                  ],
                )
              : const SizedBox(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final image = await screenshotController.capture(
                delay: const Duration(seconds: 2),
              );
              if (image == null) return;
              await General.capturarGardarImagen(image);
              General.compartirImagen(image);
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => accion(),
          ),
        ],
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
