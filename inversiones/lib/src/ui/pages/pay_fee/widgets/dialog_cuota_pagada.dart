import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/abono_response.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/labels/informacion_fila.dart';
import 'package:inversiones/src/ui/pages/widgets/labels/titulo_nombre_cliente.dart';
import 'package:screenshot/screenshot.dart';

class DialogCuotaPagada extends StatelessWidget {
  DialogCuotaPagada(
      {super.key,
      required this.dataAbono,
      this.nombreCliente,
      this.mostrarBotonCerrar,
      this.idCredito});
  final DataAbono dataAbono;
  final String? nombreCliente;
  final bool? mostrarBotonCerrar;
  final int? idCredito;

  final ScreenshotController screenshotController = ScreenshotController();
  final CreditsController controller = Get.put(CreditsController());

  @override
  Widget build(BuildContext context) {
    /// si  es un abono normal muestra todos los campos
    final bool mostrarCampo = dataAbono.tipoAbono == Constantes.CUOTA_NORMAL;

    final bool mostrarSaldoCapital =
        dataAbono.tipoAbono == Constantes.ABONO_CAPITAL ||
            dataAbono.tipoAbono == Constantes.CUOTA_NORMAL;

    final tipoAbono = dataAbono.tipoAbono == Constantes.SOLO_INTERES
        ? 'Abono interes'
        : dataAbono.tipoAbono == Constantes.ABONO_CAPITAL
            ? 'Abono capital'
            : 'Cuota normal';
    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Text(
        textAlign: TextAlign.center,
        'Informacion abono',
      ),
      content: SizedBox(
        child: Screenshot(
          controller: screenshotController,
          child: ColoredBox(
            color: Colors.white,
            child: CustomCard(
              child: Column(
                children: [
                  TituloNombreCliente(nombreCliente: nombreCliente!),
                  _mostrarContenido('Codigo crédito',
                      dataAbono.idCredito.toString(), context, true),
                  _mostrarContenido(
                      'Cuotas Pagadas',
                      dataAbono.cuotasPagadas.toString(),
                      context,
                      mostrarCampo),
                  _mostrarContenido(
                      'Cantidad de cuotas',
                      dataAbono.cantidadCuotas.toString(),
                      context,
                      mostrarCampo),
                  _mostrarContenido(
                      'Tipo abono',
                      dataAbono.tipoAbono == Constantes.SOLO_INTERES
                          ? 'Interes'
                          : dataAbono.tipoAbono == Constantes.ABONO_CAPITAL
                              ? 'Capital'
                              : 'Cuota normal',
                      context,
                      true),
                  _mostrarContenido(
                      'Valor abonado',
                      General.formatoMoneda(
                        General.stringToDouble(
                            dataAbono.valorAbonado.toString().split('.').first),
                      ),
                      context,
                      true),
                  _mostrarContenido(
                      'Saldo capital',
                      General.formatoMoneda(
                        General.stringToDouble(
                            dataAbono.saldoCapital.toString().split('.').first),
                      ),
                      context,
                      mostrarSaldoCapital),
                  _mostrarContenido(
                      'Fecha abono',
                      General.formatoFecha(
                        DateTime.parse(
                          dataAbono.fechaAbono ?? DateTime.now().toString(),
                        ),
                      ),
                      context,
                      true),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        /// solo se muestra el boton de anular abono en modulo de compartir abonos
        if (idCredito != null) _anularAbono(context),
        ShareButton(
          screenshotController: screenshotController,
          descripcion: tipoAbono,
        ),
        const HomeButton(),
        if (mostrarBotonCerrar ?? true) const CloseButtonCustom()
      ],
    );
  }

  Widget _mostrarContenido(String titulo, String informacion,
      BuildContext context, bool mostrarCampo) {
    if (mostrarCampo) {
      return InformacionFila(
          verticalPadding: 0.005,
          titulo: titulo,
          informacion: informacion,
          fontSize: 15);
    } else {
      return const SizedBox();
    }
  }

  Widget _anularAbono(BuildContext context) => IconButton(
      tooltip: 'Anular abono',
      onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              scrollable: true,
              actionsPadding: EdgeInsets.zero,
              title: const Center(child: Text('Desea anular este abono?')),
              actions: [
                TextButton(
                  onPressed: () =>
                      controller.anularUltimoAbono(dataAbono.id!, idCredito!),
                  child: const Text('Si'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'),
                ),
              ],
            ),
          ),
      icon: const Icon(Icons.money_off_csred_sharp,
          color: ColoresApp.azulPrimario));
}
