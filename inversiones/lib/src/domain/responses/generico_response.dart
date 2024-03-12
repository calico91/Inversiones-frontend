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
  int? id;
  int cuotasPagadas;
  String? estadoCuota;
  int cantidadCuotas;
  double valorAbonado;
  String tipoAbono;
  String? fechaAbono;

  DataAbono({
    this.id,
    required this.cuotasPagadas,
    this.estadoCuota,
    required this.cantidadCuotas,
    required this.valorAbonado,
    required this.tipoAbono,
    this.fechaAbono,
  });

  factory DataAbono.fromJson(Map<String, dynamic> json) => DataAbono(
        id: json["id"] == null ? null : json["id"] as int,
        cuotasPagadas: json["cuotasPagadas"] as int,
        estadoCuota:
            json["estadoCuota"] == null ? null : json["estadoCuota"] as String,
        cantidadCuotas: json["cantidadCuotas"] as int,
        valorAbonado: json["valorAbonado"] as double,
        tipoAbono: json["tipoAbono"] as String,
        fechaAbono:
            json["fechaAbono"] == null ? null : json["fechaAbono"] as String,
      );
}
