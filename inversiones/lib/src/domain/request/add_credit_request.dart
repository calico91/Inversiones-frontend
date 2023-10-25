class AddCreditRequest {
  const AddCreditRequest({
    required this.cantidadPrestada,
    required this.interesPorcentaje,
    required this.cantidadCuotas,
    required this.cedulaTitularCredito,
    required this.fechaCuota,
    required this.fechaCredito,
  });

  final double? cantidadPrestada;
  final double? interesPorcentaje;
  final int? cantidadCuotas;
  final String? cedulaTitularCredito;
  final String? fechaCuota;
  final String? fechaCredito;

  factory AddCreditRequest.fromJson(Map<String, dynamic> json) {
    return AddCreditRequest(
      cantidadPrestada: json['cantidadPrestada'] as double,
      interesPorcentaje: json['interesPorcentaje'] as double,
      cantidadCuotas: json['cantidadCuotas'] as int,
      cedulaTitularCredito: json['cedulaTitularCredito'] as String,
      fechaCuota: json['fechaCuota'] as String,
      fechaCredito: json['fechaCredito'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cantidadPrestada': cantidadPrestada,
      'interesPorcentaje': interesPorcentaje,
      'cantidadCuotas': cantidadCuotas,
      'cedulaTitularCredito': cedulaTitularCredito,
      'fechaCuota': fechaCuota,
      'fechaCredito': fechaCredito,
    };
  }
}
