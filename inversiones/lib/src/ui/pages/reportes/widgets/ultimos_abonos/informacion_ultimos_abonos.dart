import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';

class InformacionUltimosAbonos extends StatelessWidget {
  const InformacionUltimosAbonos(this.info);

  final List<AbonosRealizados>? info;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      title: const Center(child: Text('Ultimos abonos')),
      content: SizedBox(
        width: General.mediaQuery(context).width * 0.7,
        height: General.mediaQuery(context).height * (info!.length / 11),
        child: ListView.builder(
          itemCount: info!.length,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                title: Text(
                  '${info![index].nombres!} ${info![index].apellidos!}',
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Valor abonado: ${General.formatoMoneda(info![index].valorAbonado)}',
                    ),
                    Text(
                      'Fecha de pago: ${info![index].fechaAbono!}',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: const [CloseButtonCustom()],
    );
  }
}
