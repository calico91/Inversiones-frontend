class AddCreditRequest {
  const AddCreditRequest(
      {required this.valorCredito,
      required this.interesPorcentaje,
      required this.cantidadCuotas,
      this.cedulaTitularCredito,
      required this.fechaCuota,
      required this.fechaCredito,
      required this.modalidad,
      required this.usuario,
      this.renovacion,
      this.valorRenovacion,
      this.idCreditoActual,
      this.idCliente});

  final double valorCredito;
  final double interesPorcentaje;
  final int cantidadCuotas;
  final String? cedulaTitularCredito;
  final String fechaCuota;
  final String fechaCredito;
  final Modalidad modalidad;
  final String usuario;
  final bool? renovacion;
  final double? valorRenovacion;
  final int? idCreditoActual;
  final int? idCliente;

  Map<String, dynamic> toJson() => {
        'valorCredito': valorCredito,
        'interesPorcentaje': interesPorcentaje,
        'cantidadCuotas': cantidadCuotas,
        'cedulaTitularCredito': cedulaTitularCredito,
        'fechaCuota': fechaCuota,
        'fechaCredito': fechaCredito,
        "modalidad": modalidad.toJson(),
        "usuario": usuario,
        "renovacion": renovacion,
        "valorRenovacion": valorRenovacion,
        "idCreditoActual": idCreditoActual,
        "idCliente": idCliente
      };
}

class Modalidad {
  final int id;
  final String? description;

  Modalidad({
    required this.id,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
