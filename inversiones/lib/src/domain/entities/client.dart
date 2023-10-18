import 'package:inversiones/src/domain/entities/credito.dart';

class Client {
  const Client({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.email,
    required this.celular,
    required this.pais,
    required this.cedula,
    this.listaCreditos,
  });

  final int? id;
  final String nombres;
  final String apellidos;
  final String email;
  final String celular;
  final String pais;
  final String cedula;
  final List<Credito>? listaCreditos;

  factory Client.fromJson(Map<String, dynamic> json) {
    final List<Credito> listaCreditos = (json['listaCreditos']) == null
        ? List.empty()
        : List<Credito>.from(
            (json['listaCreditos'] as List<dynamic>).map((element) {
              return Credito.fromJson(element as Map<String, dynamic>);
            }),
          );

    return Client(
      id: json['id'] as int,
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      email: json['email'] as String,
      celular: json['celular'] as String,
      pais: json['pais'] as String,
      cedula: json['cedula'] as String,
      listaCreditos: listaCreditos,
    );
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
    };
  }
}
