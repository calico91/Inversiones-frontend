import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/error_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  final String celular;
  final String? mensaje;
  final Color? color;

  const WhatsAppButton(
      {super.key, required this.celular, this.mensaje, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? Colors.blue,
      tooltip: 'Enviar WhatsApp',
      onPressed: () => _enviarWhatsApp('+57$celular', mensaje ?? ''),
      icon: const FaIcon(FontAwesomeIcons.whatsapp),
    );
  }

  Future<void> _enviarWhatsApp(String numero, String mensaje) async {
    InstalledApps.getInstalledApps();

    final Uri url = Uri.parse(
        'whatsapp://send?phone=$numero&text=${Uri.encodeFull(mensaje)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.showSnackbar(const ErrorSnackbar('No se pudo abrir WhatsApp.'));
    }
  }
}
