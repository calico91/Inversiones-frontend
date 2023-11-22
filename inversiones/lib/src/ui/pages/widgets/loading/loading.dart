import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class Loading extends StatelessWidget {
  const Loading({
    this.vertical,
    this.horizontal,
    this.circularLoading = true,
  });

  final double? vertical;
  final double? horizontal;
  final bool? circularLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? General.mediaQuery(context).width * 0.41,
        vertical: vertical ?? General.mediaQuery(context).height * 0.15,
      ),
      child: circularLoading!
          ? const CircularProgressIndicator.adaptive()
          : const LinearProgressIndicator(),
    );
  }
}
