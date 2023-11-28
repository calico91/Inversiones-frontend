import 'dart:convert';

GenericoResponse genericoResponseFromJson(String str) =>
    GenericoResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class GenericoResponse {
  DataAbono? dataAbono;
  String message;
  int status;

  GenericoResponse({
    this.dataAbono,
    required this.message,
    required this.status,
  });

  factory GenericoResponse.fromJson(Map<String, dynamic> json) =>
      GenericoResponse(
        dataAbono: DataAbono.fromJson(json["data"] as Map<String, dynamic>),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class DataAbono {
  String cuotasPagadas;
  String estadoCuota;
  String cantidadCuotas;

  DataAbono({
    required this.cuotasPagadas,
    required this.estadoCuota,
    required this.cantidadCuotas,
  });

  factory DataAbono.fromJson(Map<String, dynamic> json) => DataAbono(
        cuotasPagadas: json["cuotasPagadas"] as String,
        estadoCuota: json["estadoCuota"] as String,
        cantidadCuotas: json["cantidadCuotas"] as String,
      );
}
