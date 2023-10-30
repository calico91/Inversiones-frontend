import 'dart:convert';

ClientsPendingInstallmentsResponse clientsPendingInstallmentsResponseFromJson(
  String str,
) =>
    ClientsPendingInstallmentsResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

/// lista de clientes con cuotas pendientes por pagar
class ClientsPendingInstallmentsResponse {
  List<ClientsPendingInstallment>? clientsPendingInstallments;
  String message;
  int status;

  ClientsPendingInstallmentsResponse({
    this.clientsPendingInstallments,
    required this.message,
    required this.status,
  });

  factory ClientsPendingInstallmentsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      ClientsPendingInstallmentsResponse(
        clientsPendingInstallments: json["data"] == null
            ? []
            : List<ClientsPendingInstallment>.from(
                (json["data"]! as List<dynamic>).map(
                  (x) => ClientsPendingInstallment.fromJson(
                    x as Map<String, dynamic>,
                  ),
                ),
              ),
        message: json["message"] as String,
        status: json["status"] as int,
      );

  Map<String, dynamic> toJson() => {
        "ClientsPendingInstallments": clientsPendingInstallments == null
            ? []
            : List<dynamic>.from(
                clientsPendingInstallments!.map((x) => x.toJson()),
              ),
        "message": message,
        "status": status,
      };
}

class ClientsPendingInstallment {
  int? idCliente;
  String? nombres;
  String? apellidos;
  String? cedula;
  String? fechaCredito;
  double? valorCredito;
  double? valorCuota;
  String? fechaAbono;
  String? fechaCuota;
  int? idCredito;

  ClientsPendingInstallment({
    this.idCliente,
    this.nombres,
    this.apellidos,
    this.cedula,
    this.valorCuota,
    this.fechaCredito,
    this.valorCredito,
    this.fechaAbono,
    this.fechaCuota,
    this.idCredito,
  });

  factory ClientsPendingInstallment.fromJson(Map<String, dynamic> json) =>
      ClientsPendingInstallment(
        idCliente: json["idCliente"] as int,
        nombres: json["nombres"] as String,
        apellidos: json["apellidos"] as String,
        cedula: json["cedula"] as String,
        fechaCredito: json["fechaCredito"] as String,
        valorCredito: json["valorCredito"] as double,
        valorCuota: json["valorCuota"] as double,
        fechaAbono:
            json["fechaAbono"] == null ? null : json["fechaAbono"] as String,
        fechaCuota: json["fechaCuota"] as String,
        idCredito: json["idCredito"] as int,
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "nombres": nombres,
        "apellidos": apellidos,
        "cedula": cedula,
        "fechaCredito": fechaCredito,
        "valorCredito": valorCredito,
        "valorCuota": valorCuota,
        "fechaAbono": fechaAbono,
        "fechaCuota": fechaCuota,
        "idCredito": idCredito,
      };
}
