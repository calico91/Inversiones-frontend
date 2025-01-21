import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/share_button.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/whatsapp_button.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card.dart';
import 'package:screenshot/screenshot.dart';

class ModalInformacionCliente extends StatelessWidget {
  final Client data;
  final ScreenshotController screenshotController = ScreenshotController();

  ModalInformacionCliente({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Center(child: Text('Informacion cliente')),
      content: SizedBox(
        child: Screenshot(
          controller: screenshotController,
          child: CustomCard(
            child: Column(children: [
              _informacionCliente(context, 'Cedula', data.cedula),
              _informacionCliente(context, 'Nombres', data.nombres,
                  maxLines: 2),
              _informacionCliente(context, 'Apellidos', data.apellidos,
                  maxLines: 2),
              _informacionCliente(context, 'Celular', data.celular),
              _informacionCliente(context, 'Direccion', data.direccion,
                  maxLines: 2),
            ]),
          ),
        ),
      ),
      actions: [
        WhatsAppButton(celular: data.celular),
        ShareButton(
            screenshotController: screenshotController, descripcion: ''),
        const CloseButtonCustom()
      ],
    );
  }

  Widget _informacionCliente(BuildContext context, titulo, String valor,
          {int? maxLines}) =>
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$titulo:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
                width: General.mediaQuery(context).width * 0.4,
                child: Text(valor,
                    textAlign: TextAlign.right, maxLines: maxLines)),
          ],
        ),
        const SizedBox(height: 3)
      ]);
}
