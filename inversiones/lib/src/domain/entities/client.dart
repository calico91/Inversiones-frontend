import 'package:inversiones/src/domain/entities/credit.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class Client {
  const Client(
      {this.id,
      this.nombres,
      this.apellidos,
      this.email,
      this.celular,
      this.pais,
      this.cedula,
      this.direccion,
      this.observaciones,
      this.listaCreditos,
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
  final List<Credit>? listaCreditos;
  final Iterable<ImageFile>? imagenes;

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
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
        listaCreditos: json['listaCreditos'] == null
            ? List.empty()
            : List<Credit>.from(
                (json['listaCreditos'] as List<dynamic>).map((element) {
                return Credit.fromJson(element as Map<String, dynamic>);
              })));
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
      'celular': celular,
      'pais': pais,
      'cedula': cedula,
      'direccion': direccion,
      'observaciones': observaciones
    };
  }
}
