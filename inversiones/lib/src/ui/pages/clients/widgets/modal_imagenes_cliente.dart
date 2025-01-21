import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inversiones/src/domain/responses/clientes/imagenes_cliente_response.dart';
import 'package:inversiones/src/ui/pages/widgets/buttons/close_button_custom.dart';
import 'package:photo_view/photo_view.dart';

class ModalImagenesCliente extends StatelessWidget {
  final List<ImagenCliente> imagenes;

  const ModalImagenesCliente({super.key, required this.imagenes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GridView.builder(
          shrinkWrap:
              true, // Permite que el GridView ajuste su tamaño al contenido
          physics:
              const NeverScrollableScrollPhysics(), // Evita el scroll independiente
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Número de columnas
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: imagenes.length,
          itemBuilder: (context, index) {
            final imagen = imagenes[index];
            return GestureDetector(
              onTap: () => _mostrarImagenGrande(context, imagen),
              child: Card(
                elevation: 2,
                child: Image.memory(
                  base64Decode(imagen.base64 ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      actions: const [CloseButtonCustom()],
    );
  }

  void _mostrarImagenGrande(BuildContext context, ImagenCliente imagen) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          child: PhotoView(
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            imageProvider: MemoryImage(base64Decode(imagen.base64 ?? '')),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Lógica de compartir
            },
          ),
          const CloseButtonCustom(),
        ],
      ),
    );
  }
}
