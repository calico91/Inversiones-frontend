import 'dart:convert';

AbonoResponse abonoResponseFromJson(String str) =>
    AbonoResponse.fromJson(json.decode(str) as Map<String, dynamic>);

class AbonoResponse {
  DataAbono? dataAbono;
  String message;
  int status;

  AbonoResponse({this.dataAbono, required this.message, required this.status});

  factory AbonoResponse.fromJson(Map<String, dynamic> json) => AbonoResponse(
      dataAbono: DataAbono.fromJson(json["data"] as Map<String, dynamic>),
      message: json["message"] as String,
      status: json["status"] as int);
}

class DataAbono {
  int? id;
  int cuotasPagadas;
  String? estadoCuota;
  int cantidadCuotas;
  double valorAbonado;
  String tipoAbono;
  String? fechaAbono;
  double? saldoCapital;

  DataAbono(
      {this.id,
      required this.cuotasPagadas,
      this.estadoCuota,
      required this.cantidadCuotas,
      required this.valorAbonado,
      required this.tipoAbono,
      this.fechaAbono,
      this.saldoCapital});

  factory DataAbono.fromJson(Map<String, dynamic> json) => DataAbono(
        id: json["id"] == null ? null : json["id"] as int,
        cuotasPagadas: json["cuotasPagadas"] as int,
        estadoCuota:
            json["estadoCuota"] == null ? null : json["estadoCuota"] as String,
        cantidadCuotas: json["cantidadCuotas"] as int,
        valorAbonado: json["valorAbonado"] as double,
        saldoCapital: json["saldoCapital"] == null
            ? null
            : json["saldoCapital"] as double,
        tipoAbono: json["tipoAbono"] as String,
        fechaAbono:
            json["fechaAbono"] == null ? null : json["fechaAbono"] as String,
      );
}
