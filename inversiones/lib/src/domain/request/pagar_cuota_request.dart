class PagarCuotaRequest {
  const PagarCuotaRequest({
    required this.fechaAbono,
    required this.valorAbonado,
    required this.soloInteres,
    required this.idCuotaCredito,
  });

  final String fechaAbono;
  final double valorAbonado;
  final bool soloInteres;
  final int idCuotaCredito;

  Map<String, dynamic> toJson() {
    return {
      'fechaAbono': fechaAbono,
      'valorAbonado': valorAbonado,
      'soloInteres': soloInteres,
      'idCuotaCredito': idCuotaCredito,
    };
  }
}
