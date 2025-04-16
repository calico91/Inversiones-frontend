import 'package:flutter/material.dart';

class TituloNombreCliente extends StatelessWidget {
  final String nombreCliente;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TituloNombreCliente(
      {super.key,
      required this.nombreCliente,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            maxLines: 2,
            textAlign: TextAlign.center,
            nombreCliente,
            style: TextStyle(fontWeight: fontWeight, fontSize: fontSize)),
        const Divider(color: Colors.black),
      ],
    );
  }
}
