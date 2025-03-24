import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/home_button.dart';

class DialogEstadoCredito extends StatelessWidget {
  const DialogEstadoCredito({super.key, required this.info});
  final String info;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: EdgeInsets.zero,
      title: const Text(
        textAlign: TextAlign.center,
        'Informacion estado crédito',
      ),
      content: Text(info),
      actions: const [HomeButton(), CloseButtonCustom()],
    );
  }
}
