class SaldarCreditoRequest {
  const SaldarCreditoRequest({
    required this.idCredito,
    required this.valorPagado,
  });

  final int idCredito;
  final double valorPagado;

  Map<String, dynamic> toJson() {
    return {
      'id_credito': idCredito,
      'valor_pagado': valorPagado,
    };
  }
}
