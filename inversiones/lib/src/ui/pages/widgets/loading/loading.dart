import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({required this.vertical, required this.horizontal});

  final double vertical;
  final double horizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
