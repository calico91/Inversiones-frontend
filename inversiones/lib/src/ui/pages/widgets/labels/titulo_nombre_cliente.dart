import 'package:flutter/material.dart';

class TituloNombreCliente extends StatelessWidget {
  final String nombreCliente;

  const TituloNombreCliente({super.key, required this.nombreCliente});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            textAlign: TextAlign.center,
            nombreCliente,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Divider(color: Colors.black),
      ],
    );
  }
}
