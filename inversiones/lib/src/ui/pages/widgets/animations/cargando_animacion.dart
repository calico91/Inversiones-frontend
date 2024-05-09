import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:lottie/lottie.dart';

class CargandoAnimacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Constantes.CARGANDO);
  }
}
