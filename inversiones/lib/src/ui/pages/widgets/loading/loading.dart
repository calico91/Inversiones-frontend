import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, 
    this.vertical = 0.15,
    this.horizontal = 0.41,
    this.circularLoading = true,
  });

  final double? vertical;
  final double? horizontal;
  final bool? circularLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: General.mediaQuery(context).width * horizontal!,
        vertical: General.mediaQuery(context).height * vertical!,
      ),
      child: circularLoading!
          ? const CircularProgressIndicator.adaptive()
          : const LinearProgressIndicator(),
    );
  }
}
