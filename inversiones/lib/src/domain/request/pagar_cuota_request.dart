class PagarCuotaRequest {
  const PagarCuotaRequest({
    required this.fechaAbono,
    required this.valorAbonado,
    required this.tipoAbono,
    required this.idCuotaCredito,
    this.estadoCredito,
  });

  final String fechaAbono;
  final String tipoAbono;
  final double valorAbonado;
  final int idCuotaCredito;
  final String? estadoCredito;

  Map<String, dynamic> toJson() {
    return {
      'fechaAbono': fechaAbono,
      'tipoAbono': tipoAbono,
      'valorAbonado': valorAbonado,
      'idCuotaCredito': idCuotaCredito,
      'estadoCredito': estadoCredito,
    };
  }
}
