import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/splash/splash_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Scaffold(
            body: AnimatedSplashScreen(
              backgroundColor: Colors.grey,
              splash: const CargandoAnimacion(),
              nextScreen: const SizedBox(),
              splashIconSize: General.mediaQuery(context).height * 0.9,
              animationDuration: const Duration(seconds: 3),
              splashTransition: SplashTransition.scaleTransition,
            ),
          );
        });
  }
}
