import 'dart:convert';

import 'package:inversiones/src/domain/responses/clientes/imagenes_cliente_response.dart';

ClientImagesResponse clientImagesResponseResponseFromJson(String str) {
  return ClientImagesResponse.fromJson(
      json.decode(str) as Map<String, dynamic>);
}

class ClientImagesResponse {
  const ClientImagesResponse({
    required this.status,
    required this.message,
    this.clientImages,
  });

  final int status;
  final String message;
  final ClientImages? clientImages;

  factory ClientImagesResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return ClientImagesResponse(
      status: status,
      message: json['message'] as String,
      clientImages: status == 200
          ? ClientImages.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ClientImages {
  const ClientImages(
      {this.id,
      this.nombres,
      this.apellidos,
      this.email,
      this.celular,
      this.pais,
      this.cedula,
      this.direccion,
      this.observaciones,
      this.imagenes});

  final int? id;
  final String? nombres;
  final String? apellidos;
  final String? email;
  final String? celular;
  final String? pais;
  final String? direccion;
  final String? observaciones;
  final String? cedula;
  final List<ImagenCliente>? imagenes;

  factory ClientImages.fromJson(Map<String, dynamic> json) {
    return ClientImages(
        id: json['id'] == null ? 0 : json['id'] as int,
        nombres: json['nombres'] == null ? '' : json['nombres'] as String,
        apellidos: json['apellidos'] == null ? '' : json['apellidos'] as String,
        email: json['email'] == null ? '' : json['email'] as String,
        celular: json['celular'] == null ? '' : json['celular'] as String,
        pais: json['pais'] == null ? '' : json['pais'] as String,
        cedula: json['cedula'] == null ? '' : json['cedula'] as String,
        direccion: json['direccion'] == null ? '' : json['direccion'] as String,
        observaciones: json['observaciones'] == null
            ? ''
            : json['observaciones'] as String,
        imagenes: json['observaciones'] == null
            ? null
            : List<ImagenCliente>.from((json['imagenes'] as List<dynamic>).map(
                (element) =>
                    ImagenCliente.fromJson(element as Map<String, dynamic>))));
  }
}
