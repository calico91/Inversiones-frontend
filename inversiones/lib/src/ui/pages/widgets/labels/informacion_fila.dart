import 'package:flutter/widgets.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class InformacionFila extends StatelessWidget {
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? fontSize;
  final String titulo;
  final String informacion;

  const InformacionFila(
      {super.key,
      required this.titulo,
      required this.informacion,
      this.fontSize = 20,
      this.verticalPadding = 0.01,
      this.horizontalPadding = 0.04});
  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = General.mediaQuery(context);

    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: mediaQuery.height * verticalPadding!,
            horizontal: mediaQuery.width * horizontalPadding!),
        child: Row(children: [
          Text('$titulo:',
              style:
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500)),
          Expanded(child: Container()),
          Text(informacion,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300))
        ]));
  }
}
