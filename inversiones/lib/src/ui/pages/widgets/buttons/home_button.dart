import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Inicio',
      onPressed: () => _irAlHome(),
      icon: const Icon(Icons.home,color: Colors.blue,),
    );
  }

  void _irAlHome() {
    Get.offAllNamed(RouteNames.navigationBar);
  }
}
