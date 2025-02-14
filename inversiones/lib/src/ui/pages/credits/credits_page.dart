import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/formulario_credito/dialog_config_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/formulario_credito/formulario_credito.dart';
import 'package:inversiones/src/ui/pages/credits/widgets/lista_creditos_activos/lista_creditos_activos.dart';
import 'package:inversiones/src/ui/pages/widgets/appbar/app_bar_custom.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom('Creditos', actions: [DialogConfigCredito()]),
      body: ListView(
        children: const [FormularioCredito(), ListaCreditosActivos()],
      ),
    );
  }
}
