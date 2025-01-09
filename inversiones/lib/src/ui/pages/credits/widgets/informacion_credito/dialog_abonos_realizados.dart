import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:screenshot/screenshot.dart';

class DialogAbonosRealizados extends StatelessWidget {
  DialogAbonosRealizados({required this.abonosRealizados});
  final List<AbonosRealizados> abonosRealizados;

  final ScreenshotController screenshotController = ScreenshotController();
  final CreditsController controller = Get.find<CreditsController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
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
                        onTap: () => controller
                            .consultarAbonoPorId(abonosRealizados[index].id!),
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
        const CloseButtonCustom(),
      ],
    );
  }

  ///titulo que se muestra informacion clientes
  Widget _showClientTitle(
          List<AbonosRealizados> abonosRealizados, int index, Size size) =>
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Valor abono',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  General.formatoMoneda(abonosRealizados[index].valorAbonado),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha abono'),
                Text(
                  abonosRealizados[index].fechaAbono!,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _showClientSubtitle(
      List<AbonosRealizados> abonosRealizados, int index, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            validarTipoAbono(abonosRealizados[index].tipoAbono!.toUpperCase()),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: Text(
            "Cuota número: ${abonosRealizados[index].cuotaNumero}",
            overflow: TextOverflow.ellipsis,
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
