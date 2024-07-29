import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom(this.title, {this.actions, this.centrarTitulo});
  final String title;
  final List<Widget>? actions;
  final double? centrarTitulo;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white12,
        title: centrarTitulo == null
            ? Center(
                child: Text(title,
                    style: const TextStyle(color: Colors.black, fontSize: 17)))
            : Padding(
                padding: EdgeInsets.only(
                    left: General.mediaQuery(context).width * centrarTitulo!),
                child: Text(title,
                    style: const TextStyle(color: Colors.black, fontSize: 17))),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
