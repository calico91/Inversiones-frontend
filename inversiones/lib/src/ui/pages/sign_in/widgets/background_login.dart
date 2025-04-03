import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _FondoAzul(),
        _HeaderIcon(),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
      child: Image.asset('assets/icono_app.png',
          color: Colors.white,
          width: double.infinity,
          height: General.mediaQuery(context).height * 0.3));
}

class _FondoAzul extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.32,
      decoration: const BoxDecoration(
        color: ColoresApp.azulPrimario,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }
}
