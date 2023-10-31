import 'package:flutter/material.dart';

class Loading {
  const Loading({this.vertical = 410, this.horizontal = 180});

  final double? vertical;
  final double? horizontal;

  Widget linearLoading() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
      child: const LinearProgressIndicator(),
    );
  }

  Widget circularLoading() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
