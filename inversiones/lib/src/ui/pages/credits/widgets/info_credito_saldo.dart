import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:screenshot/screenshot.dart';

class InfoCreditoSaldoModal extends StatelessWidget {
  final String title;
  final InfoCreditoySaldo info;
  final VoidCallback? accion;
  final int idCredito;

  final ScreenshotController screenshotController = ScreenshotController();

  InfoCreditoSaldoModal({
    required this.title,
    required this.info,
    this.accion,
    required this.idCredito,
  });

  @override
  Widget build(BuildContext context) {
    final CreditsController controllerCredits = Get.find<CreditsController>();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Informacion credito',
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: () => compartirImagen(),
            icon: const Icon(Icons.share),
          )
        ],
      ),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.46,
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: ColoredBox(
                color: Colors.white,
                child: Column(
                  children: [
                    _showInfoCredito('Id credito', idCredito.toString()),
                    _showInfoCredito(
                      'Numero cuotas',
                      info.numeroCuotas!.toString(),
                    ),
                    _showInfoCredito(
                      'Cuotas pagadas',
                      (info.cuotaNumero! - 1).toString(),
                    ),
                    _showInfoCredito(
                      'Interes',
                      '${info.interesPorcentaje!.toStringAsFixed(0)}%',
                    ),
                    _showInfoCredito('Fecha credito', info.fechaCredito!),
                    _showInfoCredito('Fecha cuota', info.fechaCuota!),
                    _showInfoCredito('Ultima pagada', info.ultimaCuotaPagada!),
                    _showInfoCredito(
                      'Valor credito',
                      General.formatoMoneda(info.valorCredito),
                    ),
                    _showInfoCredito(
                      'Valor cuota',
                      General.formatoMoneda(info.valorCuota),
                    ),
                    _showInfoCredito(
                      'Valor interes',
                      General.formatoMoneda(info.valorInteres),
                    ),
                    _showInfoCredito(
                      'Interes a hoy',
                      General.formatoMoneda(info.interesHoy),
                    ),
                    _showInfoCredito(
                      'Saldo credito',
                      General.formatoMoneda(info.saldoCredito),
                    ),
                    _showInfoCredito(
                      'Capital pagado',
                      General.formatoMoneda(info.capitalPagado),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: General.mediaQuery(context).height * 0.01,
              ),
              child: Form(
                key: controllerCredits.formKeyAbonoCapital,
                child: TextFieldBase(
                  title: 'Abonar',
                  controller: controllerCredits.abonar,
                  textInputType: TextInputType.number,
                  validateText: ValidateText.creditValue,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (controllerCredits.validarFormAbonoCapital()) {
              _abonar(
                controllerCredits,
                context,
                true,
                info.id!,
                info.interesHoy!,
              );
            }
          },
          child: const Text('Abonar capital'),
        ),
        TextButton(
          onPressed: () {
            if (controllerCredits.validarFormAbonoCapital()) {
              _abonar(
                controllerCredits,
                context,
                false,
                info.id!,
                info.interesHoy!,
              );
            }
          },
          child: const Text('Abonar interes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Future<void> compartirImagen() async {
    final image = await screenshotController.capture(
      delay: const Duration(seconds: 2),
    );
    if (image == null) return;
    await General.capturarGardarImagen(image);
    General.compartirImagen(image);
  }
}

Widget _showInfoCredito(
  String title,
  String info,
) =>
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Text(
            '$title:',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(child: Container()),
        Text(
          info,
          textAlign: TextAlign.right,
        ),
      ],
    );

Object _abonar(
  CreditsController controllerCredits,
  BuildContext context,
  bool abonoCapital,
  int idCuotaCredito,
  double valorInteres,
) {
  final String titulo =
      abonoCapital ? 'Desea abonar capital?' : 'Desea abonar interes?';

  final String estadoCredito = controllerCredits.validarEstadoCredito();

  final double interes =
      estadoCredito == Constantes.CREDITO_PAGADO ? valorInteres : 0;

  final String tipoAbono =
      abonoCapital ? Constantes.ABONO_CAPITAL : Constantes.SOLO_INTERES;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: General.mediaQuery(context).height * 0.02,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controllerCredits.pagarInteresOCapital(
              General.mediaQuery(context),
              tipoAbono,
              estadoCredito,
              idCuotaCredito,
              interes,
            );
          },
          child: const Text('Si'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    ),
  );
}
