import 'package:flutter/material.dart';

class TittleAppbar extends StatelessWidget {
  const TittleAppbar(this.data);
  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(color: Colors.black, fontSize: 17),
    );
  }
}
