import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class DialogCuotaPagada extends StatelessWidget {
  const DialogCuotaPagada({required this.accion, this.dataAbono});
  final VoidCallback accion;
  final DataAbono? dataAbono;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        TextButton(
          onPressed: () => accion(),
          child: const Text('Aceptar'),
        ),
      ],
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
