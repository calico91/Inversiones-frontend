import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:screenshot/screenshot.dart';

class ShareButton extends StatelessWidget {
  const ShareButton(
      {super.key,
      required this.screenshotController,
      required this.descripcion,
      this.color});

  final ScreenshotController screenshotController;
  final String descripcion;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      tooltip: 'Compartir',
      onPressed: () => _compartirImagen(),
      icon: Icon(Icons.share, color: color ?? ColoresApp.azulPrimario),
    );
  }

  Future<void> _compartirImagen() async {
    final image = await screenshotController.capture(
      delay: const Duration(milliseconds: 500),
    );
    if (image == null) return;
    await General.capturarGardarImagen(image);
    General.compartirImagen(image, descripcion);
  }
}
