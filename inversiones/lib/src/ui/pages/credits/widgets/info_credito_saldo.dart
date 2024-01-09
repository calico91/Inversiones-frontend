import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';
import 'package:screenshot/screenshot.dart';

class InfoCreditoSaldoModal extends StatelessWidget {
  final InfoCreditoySaldo info;
  final VoidCallback? accion;
  final int idCredito;

  final ScreenshotController screenshotController = ScreenshotController();

  InfoCreditoSaldoModal({
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
          Text(
            Constantes.INFORMACION_CREDITO,
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: () => _modificarCredito(
              context,
              controllerCredits,
              idCredito,
              info.fechaCuota!,
            ),
            icon: const Icon(color: Colors.blue, Icons.edit),
          ),
          ShareButton(
            screenshotController: screenshotController,
            descripcion: Constantes.INFORMACION_CREDITO,
          ),
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
                child: CustomCard(
                  child: Column(
                    children: [
                      _showInfoCredito('Id credito', idCredito.toString()),
                      _showInfoCredito('Modalidad', info.modalidad!),
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
                      _showInfoCredito(
                        'Ultima pagada',
                        info.ultimaCuotaPagada!,
                      ),
                      _showInfoCredito(
                        'Valor credito',
                        General.formatoMoneda(info.valorCredito),
                      ),
                      _showInfoCredito(
                        'Interes a hoy',
                        General.formatoMoneda(info.interesHoy),
                      ),
                      _showInfoCredito(
                        'Interes mes',
                        General.formatoMoneda(info.valorInteres),
                      ),
                      _showInfoCredito(
                        'Valor por Mora',
                        General.formatoMoneda(info.interesMora),
                      ),
                      _showInfoCredito(
                        'Valor cuota',
                        General.formatoMoneda(info.valorCuota),
                      ),
                      _showInfoCredito(
                        'Capital pagado',
                        General.formatoMoneda(info.capitalPagado),
                      ),
                      _showInfoCredito(
                        'Saldo credito',
                        General.formatoMoneda(info.saldoCredito),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Form(
              key: controllerCredits.formKeyAbonoCapital,
              child: TextFieldBase(
                title: 'Abonar',
                controller: controllerCredits.abonar,
                textInputType: TextInputType.number,
                validateText: ValidateText.creditValue,
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

Object _modificarCredito(
  BuildContext context,
  CreditsController controller,
  int idCredito,
  String fechaCuota,
) {
  final Map<String, String> estadosCredito = {
    Constantes.CREDITO_ACTIVO: 'Activo',
    Constantes.CREDITO_PAGADO: 'Pagado',
    Constantes.CREDITO_ANULADO: 'Anulado',
  };

  String estadoCreditoInicial = Constantes.CREDITO_ACTIVO;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Center(child: Text('Editar credito')),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.2,
        child: Column(
          children: [
            Row(
              children: [
                TextFieldCalendar(
                  title: 'Nueva fecha cuota',
                  paddingHorizontal: 20,
                  controller: controller.nuevaFechaCuota,
                  onTap: () async => controller.showCalendar(
                    context,
                    controller.nuevaFechaCuota,
                    DateTime.parse(fechaCuota),
                    DateTime.parse(fechaCuota),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 20),
                  child: IconButton(
                    iconSize: 40,
                    onPressed: () => controller.modificarFechaCuota(
                      General.mediaQuery(context),
                      idCredito,
                    ),
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton<String>(
                  items: estadosCredito
                      .map((key, value) {
                        return MapEntry(
                          key,
                          DropdownMenuItem<String>(
                            value: key,
                            child: Text(value),
                          ),
                        );
                      })
                      .values
                      .toList(),
                  value: estadoCreditoInicial,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      estadoCreditoInicial = newValue;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}
