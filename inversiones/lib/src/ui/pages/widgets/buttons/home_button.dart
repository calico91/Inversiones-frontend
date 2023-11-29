import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _irAlHome(),
      icon: const Icon(Icons.home),
    );
  }

  void _irAlHome() {
    Get.offAllNamed(RouteNames.home);
  }
}
