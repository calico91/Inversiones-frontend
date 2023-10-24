import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({this.vertical = 410, this.horizontal = 180});

  final double? vertical;
  final double? horizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
