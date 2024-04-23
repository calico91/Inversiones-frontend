import 'package:flutter/material.dart';

class CloseButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.close_rounded));
  }
}
