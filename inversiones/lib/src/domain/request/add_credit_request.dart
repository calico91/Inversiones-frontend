class AddCreditRequest {
  const AddCreditRequest(
      {required this.valorCredito,
      required this.interesPorcentaje,
      required this.cantidadCuotas,
      required this.fechaCuota,
      required this.fechaCredito,
      required this.modalidad,
      required this.usuario,
      required this.diasMora,
      required this.valorMora,
      this.cedulaTitularCredito,
      this.renovacion,
      this.valorRenovacion,
      this.idCreditoActual,
      this.idCliente});

  final double valorCredito;
  final double interesPorcentaje;
  final int cantidadCuotas;
  final String fechaCuota;
  final String fechaCredito;
  final Modalidad modalidad;
  final String usuario;
  final int diasMora;
  final double valorMora;
  final bool? renovacion;
  final double? valorRenovacion;
  final int? idCreditoActual;
  final int? idCliente;
  final String? cedulaTitularCredito;

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
        "idCliente": idCliente,
        "valorMora": valorMora,
        "diasMora": diasMora
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
