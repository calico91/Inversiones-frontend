import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 180, vertical: 410),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
