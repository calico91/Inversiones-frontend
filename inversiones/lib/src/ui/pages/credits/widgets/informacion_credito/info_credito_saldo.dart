import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/informacion_credito/dialog_renovar_credito.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
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

  InfoCreditoSaldoModal(
      {required this.info, this.accion, required this.idCredito});

  @override
  Widget build(BuildContext context) {
    final CreditsController controllerCredits = Get.find<CreditsController>();

    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Text(Constantes.INFORMACION_CREDITO, textAlign: TextAlign.center),
          SizedBox(
            width: General.mediaQuery(context).width * 0.1,
            child: _editarCreditoBoton(
                context, controllerCredits, idCredito, info.fechaCuota!),
          ),
          SizedBox(
            width: General.mediaQuery(context).width * 0.1,
            child: ShareButton(
                screenshotController: screenshotController,
                descripcion: Constantes.INFORMACION_CREDITO),
          )
        ],
      ),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.49,
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: ColoredBox(
                color: Colors.white,
                child: CustomCard(
                  child: Column(
                    children: [
                      Text(
                          textAlign: TextAlign.center,
                          controllerCredits.nombreClienteSeleccionado!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      _showInfoCredito('Modalidad', info.modalidad!),
                      _showInfoCredito(
                          'Numero cuotas', info.numeroCuotas!.toString()),
                      _showInfoCredito(
                          'Cuotas pagadas', (info.cuotaNumero!).toString()),
                      _showInfoCredito(
                          'Interes', '${info.interesPorcentaje!}%'),
                      _showInfoCredito('Fecha credito', info.fechaCredito!),
                      _showInfoCredito('Fecha cuota', info.fechaCuota!),
                      _showInfoCredito(
                          'Ultima pagada', info.ultimaCuotaPagada!),
                      _showInfoCredito('Valor credito',
                          General.formatoMoneda(info.valorCredito)),
                      _showInfoCredito('Interes mes',
                          General.formatoMoneda(info.valorInteres)),
                      _showInfoCredito('Interes a hoy',
                          General.formatoMoneda(info.interesHoy)),
                      _showInfoCredito('Valor por Mora',
                          General.formatoMoneda(info.interesMora)),
                      _showInfoCredito('Valor cuota',
                          General.formatoMoneda(info.valorCuota)),
                      _showInfoCredito('Capital pagado',
                          General.formatoMoneda(info.capitalPagado)),
                      _showInfoCredito('Saldo credito',
                          General.formatoMoneda(info.saldoCredito)),
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
                  validateText: ValidateText.creditValue),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _botonSaldarCredito(context, controllerCredits, idCredito),
            _botonRenovarCredito(context),
            _botonAbonarCapitalOInteres(
                controllerCredits, context, true, info.id!, info.interesHoy!),
            _botonAbonarCapitalOInteres(
                controllerCredits, context, false, info.id!, info.interesHoy!),
            CloseButtonCustom(
              accion: () => _limpiarCampoAbonar(controllerCredits),
            )
          ],
        ),
      ],
    );
  }
}

Widget _showInfoCredito(String title, String info) => Row(
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

Object _abonar(CreditsController controllerCredits, BuildContext context,
    bool abonoCapital, int idCuotaCredito, double valorInteres) {
  final String titulo =
      abonoCapital ? 'Desea abonar capital?' : 'Desea abonar interes?';

  final String estadoCredito = abonoCapital
      ? controllerCredits.validarEstadoCredito()
      : Constantes.CREDITO_ACTIVO;

  final double interes =
      estadoCredito == Constantes.CREDITO_PAGADO ? valorInteres : 0;

  final String tipoAbono =
      abonoCapital ? Constantes.ABONO_CAPITAL : Constantes.SOLO_INTERES;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: General.mediaQuery(context).height * 0.02),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              controllerCredits.pagarInteresOCapital(
                  tipoAbono, estadoCredito, idCuotaCredito, interes);
            },
            child: const Text('Si')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
      ],
    ),
  );
}

Object _modificarCredito(BuildContext context, CreditsController controller,
    int idCredito, String fechaCuota) {
  final Map<String, String> estadosCredito = {
    Constantes.CODIGO_CREDITO_ACTIVO.toString(): 'Activo',
    Constantes.CODIGO_CREDITO_PAGADO.toString(): 'Pagado',
    Constantes.CODIGO_CREDITO_ANULADO.toString(): 'Anulado'
  };

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Center(child: Text('Editar credito')),
      content: SizedBox(
        height: General.mediaQuery(context).height * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      DateTime.parse(fechaCuota)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: General.mediaQuery(context).height * 0.03),
                  child: botonAccionEditarCredito(context,
                      () => controller.modificarFechaCuota(idCredito, context)),
                ),
              ],
            ),
            SizedBox(height: General.mediaQuery(context).height * 0.02),

            /// estado de credito
            Column(
              children: [
                Row(
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                General.mediaQuery(context).width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Estado credito'),
                            SizedBox(
                              width: General.mediaQuery(context).width * 0.39,
                              height: General.mediaQuery(context).width * 0.1,
                              child: DropdownButton<String>(
                                isExpanded: true,
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
                                value:
                                    controller.estadoCredito.value.toString(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.estadoCredito.value =
                                        int.parse(newValue);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    botonAccionEditarCredito(
                      context,
                      () => controller.modificarEstadoCredito(
                          idCredito, controller.estadoCredito.value, context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: const [CloseButtonCustom()],
    ),
  );
}

Widget botonAccionEditarCredito(BuildContext context, VoidCallback accion) {
  return IconButton(
    iconSize: 40,
    onPressed: accion,
    icon: const Icon(
      Icons.arrow_circle_right_rounded,
      color: Colors.blue,
    ),
  );
}

Widget _editarCreditoBoton(BuildContext context, CreditsController controller,
        int idCredito, String fechaCuota) =>
    IconButton(
        tooltip: "Editar credito",
        onPressed: () =>
            _modificarCredito(context, controller, idCredito, fechaCuota),
        icon: const Icon(color: Colors.blue, Icons.edit));

Widget _botonAbonarCapitalOInteres(
        CreditsController controllerCredits,
        BuildContext context,
        bool abonoCapital,
        int idCuotaCredito,
        double valorInteres) =>
    IconButton(
        tooltip: abonoCapital ? 'Abonar capital' : 'Abonar interes',
        onPressed: () {
          if (controllerCredits.validarFormAbonoCapital()) {
            _abonar(controllerCredits, context, abonoCapital, idCuotaCredito,
                valorInteres);
          }
        },
        icon: FaIcon(
            abonoCapital
                ? FontAwesomeIcons.sackDollar
                : FontAwesomeIcons.handHoldingDollar,
            color: Colors.blue));

Widget _botonRenovarCredito(BuildContext context) => IconButton(
    tooltip: 'Renovar credito',
    onPressed: () => showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => DialogRenovarCredito()),
    icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer, color: Colors.blue));

Widget _botonSaldarCredito(BuildContext context,
        CreditsController controllerCredits, int idCredito) =>
    IconButton(
        tooltip: 'Saldar credito',
        onPressed: () {
          if (controllerCredits.validarFormAbonoCapital()) {
            _mostrarModalConfirmarSaldarCredito(
                controllerCredits, context, idCredito);
          }
        },
        icon: const FaIcon(FontAwesomeIcons.sackXmark, color: Colors.blue));

Object _mostrarModalConfirmarSaldarCredito(
    CreditsController controllerCredits, BuildContext context, int idCredito) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: Text(
        'Desea saldar el credito?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: General.mediaQuery(context).height * 0.02),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              controllerCredits.saldarCredito(idCredito);
            },
            child: const Text('Si')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
      ],
    ),
  );
}

void _limpiarCampoAbonar(CreditsController controller) =>
    controller.abonar.clear();
