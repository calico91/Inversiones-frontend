import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/splash/splash_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Scaffold(
            body: AnimatedSplashScreen(
              splash: Lottie.asset(
                height:  General.mediaQuery(context).height * 0.9,
                fit: BoxFit.fill,
                'assets/splash.json'),
              nextScreen: const SizedBox(),
              splashIconSize: General.mediaQuery(context).height * 0.9,
              animationDuration: const Duration(seconds: 3),
              splashTransition: SplashTransition.scaleTransition,
            ),
          );
        });
  }
}
