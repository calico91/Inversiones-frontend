import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class ButtonActions extends StatelessWidget {
  const ButtonActions(
      {required this.onPressed,
      required this.height,
      required this.width,
      required this.label,
      required this.fontSize,
      super.key});

  final void Function() onPressed;
  final double height;
  final double width;
  final String label;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent)),
      onPressed: onPressed,
      child: Container(
        height: General.mediaQuery(context).height * height,
        width: General.mediaQuery(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColoresApp.azulPrimario,
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(color: Colors.white, fontSize: fontSize)),
        ),
      ),
    );
  }
}
