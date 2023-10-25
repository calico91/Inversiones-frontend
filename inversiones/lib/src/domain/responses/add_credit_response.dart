import 'dart:convert';

AddCreditResponse addCreditResponseFromJson(String str) =>
    AddCreditResponse.fromJson(json.decode(str) as Map<String, dynamic>);

class AddCreditResponse {
  DataCreditResponse? data;
  String? message;
  int? status;

  AddCreditResponse({
    this.data,
    this.message,
    this.status,
  });

  factory AddCreditResponse.fromJson(Map<String, dynamic> json) =>
      AddCreditResponse(
        data: json["data"] == null
            ? null
            : DataCreditResponse.fromJson(json["data"] as Map<String, dynamic>),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class DataCreditResponse {
  double? valorPrimerCuota;
  int? cantidadCuotas;
  double? valorCuotas;
  String? fechaPago;

  DataCreditResponse({
    this.valorPrimerCuota,
    this.cantidadCuotas,
    this.valorCuotas,
    this.fechaPago,
  });

  factory DataCreditResponse.fromJson(Map<String, dynamic> json) => DataCreditResponse(
        valorPrimerCuota: json["valorPrimerCuota"] as double,
        cantidadCuotas: json["cantidadCuotas"] as int,
        valorCuotas: json["valorCuotas"] as double,
        fechaPago: json["fechaPago"] as String,
      );
}
