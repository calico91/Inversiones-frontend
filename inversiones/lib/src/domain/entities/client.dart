import 'package:inversiones/src/domain/entities/credit.dart';

class Client {
  const Client(
      {this.id,
      required this.nombres,
      required this.apellidos,
      this.email,
      required this.celular,
      this.pais,
      required this.cedula,
      required this.direccion,
      required this.observaciones,
      this.listaCreditos});

  final int? id;
  final String nombres;
  final String apellidos;
  final String? email;
  final String celular;
  final String? pais;
  final String direccion;
  final String? observaciones;
  final String cedula;
  final List<Credit>? listaCreditos;

  factory Client.fromJson(Map<String, dynamic> json) {
    final String email = (json['email']) == null ? '' : json['email'] as String;
    final String pais = (json['pais']) == null ? '' : json['pais'] as String;
    final List<Credit> listaCreditos = (json['listaCreditos']) == null
        ? List.empty()
        : List<Credit>.from(
            (json['listaCreditos'] as List<dynamic>).map((element) {
            return Credit.fromJson(element as Map<String, dynamic>);
          }));

    return Client(
        id: json['id'] as int,
        nombres: json['nombres'] as String,
        apellidos: json['apellidos'] as String,
        email: email,
        celular: json['celular'] as String,
        pais: pais,
        cedula: json['cedula'] as String,
        direccion: json['direccion'] as String,
        observaciones: json['observaciones'] as String,
        listaCreditos: listaCreditos);
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
