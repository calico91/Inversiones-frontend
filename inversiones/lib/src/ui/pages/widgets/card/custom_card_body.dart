import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class CustomCardBody extends StatelessWidget {
  const CustomCardBody({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: ColoresApp.azulPrimario),
        Positioned(
          top: General.mediaQuery(context).height * 0.12,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: General.mediaQuery(context).height * 0.022,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
