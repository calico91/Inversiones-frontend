class AddCreditRequest {
  const AddCreditRequest({
    required this.valorCredito,
    required this.interesPorcentaje,
    required this.cantidadCuotas,
    required this.cedulaTitularCredito,
    required this.fechaCuota,
    required this.fechaCredito,
    required this.modalidad,
  });

  final double? valorCredito;
  final double? interesPorcentaje;
  final int? cantidadCuotas;
  final String? cedulaTitularCredito;
  final String? fechaCuota;
  final String? fechaCredito;
  final String? modalidad;

  Map<String, dynamic> toJson() {
    return {
      'valorCredito': valorCredito,
      'interesPorcentaje': interesPorcentaje,
      'cantidadCuotas': cantidadCuotas,
      'cedulaTitularCredito': cedulaTitularCredito,
      'fechaCuota': fechaCuota,
      'fechaCredito': fechaCredito,
      'modalidad': modalidad,
    };
  }
}
