import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';

import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';

class PayFeePage extends StatelessWidget {
  const PayFeePage({super.key, this.idCliente = 0});
  final int idCliente;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PayFeeController payFeeController = Get.find<PayFeeController>();
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar cuota'),
      ),
    );
  }
}
