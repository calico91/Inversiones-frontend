import 'package:flutter/material.dart';

class CustomCardList extends StatelessWidget {
  const CustomCardList({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: child);
}
