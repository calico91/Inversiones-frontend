import 'dart:convert';

AbonosRealizadosResponse abonosRealizadosResponseFromJson(String str) =>
    AbonosRealizadosResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class AbonosRealizadosResponse {
  List<AbonosRealizados>? abonosRealizados;
  String? message;
  int? status;

  AbonosRealizadosResponse({
    this.abonosRealizados,
    this.message,
    this.status,
  });

  factory AbonosRealizadosResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      AbonosRealizadosResponse(
        abonosRealizados: json["data"] == null
            ? []
            : List<AbonosRealizados>.from(
                (json["data"] as List<dynamic>).map(
                  (x) => AbonosRealizados.fromJson(
                    x as Map<String, dynamic>,
                  ),
                ),
              ),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class AbonosRealizados {
  int? id;
  double? valorAbonado;
  String? tipoAbono;
  String? fechaAbono;
  int? cuotaNumero;
  String? nombres;
  String? apellidos;

  AbonosRealizados({
    this.id,
    this.valorAbonado,
    this.tipoAbono,
    this.fechaAbono,
    this.cuotaNumero,
    this.nombres,
    this.apellidos,
  });

  factory AbonosRealizados.fromJson(Map<String, dynamic> json) =>
      AbonosRealizados(
        id: json["id"] as int,
        valorAbonado:
            json["valorAbonado"] == null ? 0 : json["valorAbonado"] as double,
        tipoAbono: json["tipoAbono"] == null ? '' : json["tipoAbono"] as String,
        fechaAbono:
            json["fechaAbono"] == null ? '' : json["fechaAbono"] as String,
        cuotaNumero:
            json["cuotaNumero"] == null ? 0 : json["cuotaNumero"] as int,
        apellidos: json["apellidos"] == null ? '' : json["apellidos"] as String,
        nombres: json["nombres"] == null ? '' : json["nombres"] as String,
      );
}
