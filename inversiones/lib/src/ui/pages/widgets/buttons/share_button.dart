import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:screenshot/screenshot.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.screenshotController,
    required this.descripcion,
    this.color,
  });

  final ScreenshotController screenshotController;
  final String descripcion;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Compartir',
      onPressed: () => _compartirImagen(),
      icon: Icon(Icons.share, color: color ?? Colors.blue),
    );
  }

  Future<void> _compartirImagen() async {
    final image = await screenshotController.capture(
      delay: const Duration(seconds: 2),
    );
    if (image == null) return;
    await General.capturarGardarImagen(image);
    General.compartirImagen(image, descripcion);
  }
}
