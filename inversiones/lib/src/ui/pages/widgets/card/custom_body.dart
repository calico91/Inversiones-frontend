import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(color: ColoresApp.azulPrimario),
          Positioned(
            top: General.mediaQuery(context).height * 0.12,
            left: 0,
            right: 0,
            child: Container(
              height: General.mediaQuery(context).height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            top: General.mediaQuery(context).height * 0.022,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: child,
            ),
          ),
        ],
      );
}
