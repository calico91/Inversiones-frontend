class PagarCuotaRequest {
  const PagarCuotaRequest({
    required this.fechaAbono,
    required this.valorAbono,
    required this.soloInteres,
    required this.idCuotaCredito,
  });

  final String fechaAbono;
  final double valorAbono;
  final bool soloInteres;
  final int idCuotaCredito;

  Map<String, dynamic> toJson() {
    return {
      'fechaAbono': fechaAbono,
      'valorAbono': valorAbono,
      'soloInteres': soloInteres,
      'idCuotaCredito': idCuotaCredito,
    };
  }
}
