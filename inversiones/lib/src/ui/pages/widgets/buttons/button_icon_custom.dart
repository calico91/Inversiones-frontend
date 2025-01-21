import 'package:flutter/material.dart';

class ButtonIconCustom extends StatelessWidget {
  const ButtonIconCustom(this.onPressed, this.icon, this.tooltip, {super.key});

  final void Function() onPressed;
  final Widget icon;
  final String tooltip;
  @override
  Widget build(BuildContext context) =>
      IconButton(tooltip: tooltip, onPressed: onPressed, icon: icon);
}
