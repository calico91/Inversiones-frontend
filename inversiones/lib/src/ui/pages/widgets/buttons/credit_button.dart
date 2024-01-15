import 'package:flutter/material.dart';

class CreditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _irCredito(context),
      icon: const Icon(
        Icons.monetization_on,
        color: Colors.blue,
      ),
    );
  }

  void _irCredito(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
