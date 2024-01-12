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
  double? valorAbonado;
  String? tipoAbono;
  String? fechaAbono;
  int? cuotaNumero;

  AbonosRealizados({
    this.valorAbonado,
    this.tipoAbono,
    this.fechaAbono,
    this.cuotaNumero,
  });

  factory AbonosRealizados.fromJson(Map<String, dynamic> json) =>
      AbonosRealizados(
        valorAbonado:
            json["valorAbonado"] == null ? 0 : json["valorAbonado"] as double,
        tipoAbono: json["tipoAbono"] == null
            ? 'Sin pago'
            : json["tipoAbono"] as String,
        fechaAbono: json["fechaAbono"] == null
            ? 'Sin pago'
            : json["fechaAbono"] as String,
        cuotaNumero: json["cuotaNumero"] as int,
      );
}
