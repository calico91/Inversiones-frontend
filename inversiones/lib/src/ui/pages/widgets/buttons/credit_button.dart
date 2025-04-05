import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';

class CreditButton extends StatelessWidget {
  const CreditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _irCredito(context),
      icon: const Icon(
        Icons.monetization_on,
        color: ColoresApp.azulPrimario,
      ),
    );
  }

  void _irCredito(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
