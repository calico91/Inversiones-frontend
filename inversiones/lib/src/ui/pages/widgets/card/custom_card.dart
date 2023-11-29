import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0.2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: General.mediaQuery(context).width * 0.02,
          vertical: General.mediaQuery(context).height * 0.008,
        ),
        child: child,
      ),
    );
  }
}
