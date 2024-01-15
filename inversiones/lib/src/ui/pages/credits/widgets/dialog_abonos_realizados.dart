import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:screenshot/screenshot.dart';

class DialogAbonosRealizados extends StatelessWidget {
  DialogAbonosRealizados({required this.abonosRealizados});
  final List<AbonosRealizados> abonosRealizados;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        'Abonos realizados',
      ),
      content: SizedBox(
        width: 300,
        height: abonosRealizados.isEmpty
            ? General.mediaQuery(context).height * 0.05
            : General.mediaQuery(context).height *
                (abonosRealizados.length / 11),
        child: abonosRealizados.isEmpty
            ? const Center(child: Text('No se han realizado abonos'))
            : Screenshot(
                controller: screenshotController,
                child: ListView.builder(
                  itemCount: abonosRealizados.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        title: _showClientTitle(
                          abonosRealizados,
                          index,
                          General.mediaQuery(context),
                        ),
                        subtitle: _showClientSubtitle(
                          abonosRealizados,
                          index,
                          General.mediaQuery(context),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      actions: [
        ShareButton(
          screenshotController: screenshotController,
          descripcion: 'Abonos realizados',
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  ///titulo que se muestra informacion clientes
  Widget _showClientTitle(
    List<AbonosRealizados> abonosRealizados,
    int index,
    Size size,
  ) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.28,
          child: Column(
            children: [
              const Text(
                overflow: TextOverflow.ellipsis,
                'Valor abono',
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                General.formatoMoneda(abonosRealizados[index].valorAbonado),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.28,
          child: Column(
            children: [
              const Text(
                'Fecha abono',
              ),
              Text(
                abonosRealizados[index].fechaAbono!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showClientSubtitle(
    List<AbonosRealizados> abonosRealizados,
    int index,
    Size size,
  ) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.28,
          child: Text(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            validarTipoAbono(abonosRealizados[index].tipoAbono!.toUpperCase()),
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: size.width * 0.28,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "Cuota numero: ${abonosRealizados[index].cuotaNumero}",
          ),
        ),
      ],
    );
  }

  String validarTipoAbono(String tipoAbono) {
    switch (tipoAbono) {
      case 'AC':
        return 'Abono capital';
      case 'CN':
        return 'Cuota normal';
      case 'SI':
        return 'Solo interes';
      default:
        return 'Cuota pendiente';
    }
  }
}
