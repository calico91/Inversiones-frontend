import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class BackgroundLogin extends StatelessWidget {
  final Widget child;

  const BackgroundLogin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          child,
        ],
      ),
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

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: size.height * 0.4,
        decoration: azulBackground(),
        child: Stack(children: [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: 10, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
        ]));
  }

  BoxDecoration azulBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue, Color.fromRGBO(14, 90, 204, 1)
      ]));
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: General.mediaQuery(context).width * 0.23,
      height: General.mediaQuery(context).height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)));
}
