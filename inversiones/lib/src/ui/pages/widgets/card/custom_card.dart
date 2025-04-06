import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  const CustomCard({super.key, required this.child, this.color});  
  @override
  Widget build(BuildContext context) {
    return Card(
        color: color ?? Colors.white,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: General.mediaQuery(context).width * 0.02,
                vertical: General.mediaQuery(context).height * 0.008),
            child: child));
  }
}
