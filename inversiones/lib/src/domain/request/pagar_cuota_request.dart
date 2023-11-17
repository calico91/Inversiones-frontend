class PagarCuotaRequest {
  const PagarCuotaRequest({
    required this.fechaAbono,
    required this.valorAbonado,
    required this.tipoAbono,
    required this.idCuotaCredito,
    required this.estadoCredito,
    required this.abonoExtra,
  });

  final String fechaAbono;
  final String tipoAbono;
  final double valorAbonado;
  final int idCuotaCredito;
  final String estadoCredito;
  final bool abonoExtra;

  Map<String, dynamic> toJson() {
    return {
      'fechaAbono': fechaAbono,
      'tipoAbono': tipoAbono,
      'valorAbonado': valorAbonado,
      'idCuotaCredito': idCuotaCredito,
      'estadoCredito': estadoCredito,
      'abonoExtra': abonoExtra,
    };
  }
}
