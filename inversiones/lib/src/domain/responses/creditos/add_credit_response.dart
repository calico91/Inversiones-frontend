import 'dart:convert';

AddCreditResponse addCreditResponseFromJson(String str) {
  return AddCreditResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class AddCreditResponse {
  DataCreditResponse? data;
  String message;
  int status;

  AddCreditResponse({
    this.data,
    required this.message,
    required this.status,
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
  String? valorPrimerCuota;
  String? cantidadCuotas;
  String? valorCuotas;
  String? fechaPago;
  String? valorCredito;
  String? nombreCliente;
  String? modalidad;
  DataCreditResponse({
    this.valorPrimerCuota,
    this.cantidadCuotas,
    this.valorCuotas,
    this.fechaPago,
    this.valorCredito,
    this.nombreCliente,
    this.modalidad,
  });

  factory DataCreditResponse.fromJson(Map<String, dynamic> json) =>
      DataCreditResponse(
        valorPrimerCuota: json["valorPrimerCuota"] as String,
        cantidadCuotas: json["cantidadCuotas"] as String,
        valorCuotas: json["valorCuotas"] as String,
        fechaPago: json["fechaPago"] as String,
        valorCredito: json["valorCredito"] as String,
        nombreCliente: json["nombreCliente"] as String,
        modalidad: json["modalidad"] as String,
      );
}
