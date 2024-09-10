class SaldarCreditoResponse {
  int idCredito;
  double valorPagado;
  String nombreCliente;
  double valorCredito;

  SaldarCreditoResponse({
    required this.idCredito,
    required this.valorPagado,
    required this.nombreCliente,
    required this.valorCredito,
  });

  factory SaldarCreditoResponse.fromJson(Map<String, dynamic> json) =>
      SaldarCreditoResponse(
        idCredito: json["id_credito"] as int,
        valorPagado: json["valor_pagado"] as double,
        nombreCliente: json["nombre_cliente"] as String,
        valorCredito: json["valor_credito"] as double,
      );
}
