import 'dart:convert';

InfoCreditosActivosResponse infoCreditosActivosResponseFromJson(String str) =>
    InfoCreditosActivosResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class InfoCreditosActivosResponse {
  List<InfoCreditosActivos>? infoCreditosActivos;
  String? message;
  int? status;

  InfoCreditosActivosResponse({
    this.infoCreditosActivos,
    this.message,
    this.status,
  });

  factory InfoCreditosActivosResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      InfoCreditosActivosResponse(
        infoCreditosActivos: json["data"] == null
            ? []
            : List<InfoCreditosActivos>.from(
                (json["data"]! as List<dynamic>).map(
                  (x) => InfoCreditosActivos.fromJson(
                    x as Map<String, dynamic>,
                  ),
                ),
              ),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class InfoCreditosActivos {
  int? idCliente;
  int? idCredito;
  String? nombres;
  String? apellidos;
  String? cedula;
  String? fechaCredito;
  double? valorCredito;

  InfoCreditosActivos({
    this.idCliente,
    this.idCredito,
    this.nombres,
    this.apellidos,
    this.cedula,
    this.fechaCredito,
    this.valorCredito,
  });

  factory InfoCreditosActivos.fromJson(Map<String, dynamic> json) =>
      InfoCreditosActivos(
        idCliente: json["idCliente"] as int,
        idCredito: json["idCredito"] as int,
        nombres: json["nombres"] as String,
        apellidos: json["apellidos"] as String,
        cedula: json["cedula"] as String,
        fechaCredito: json["fechaCredito"] as String,
        valorCredito: json["valorCredito"] as double,
      );
}
