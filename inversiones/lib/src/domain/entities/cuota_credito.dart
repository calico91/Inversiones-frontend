import 'package:inversiones/src/domain/entities/credit.dart';

class CuotaCredito {
  const CuotaCredito({
    this.id,
    required this.valorCuota,
    required this.fechaCuota,
    required this.numeroCuotas,
    required this.cuotaNumero,
    this.valorAbonado,
    required this.valorCapital,
    required this.valorInteres,
    required this.valorCredito,
    required this.interesPorcentaje,
    this.fechaAbono,
    required this.credito,
  });

  final int? id;
  final double valorCuota;
  final String fechaCuota;
  final int numeroCuotas;
  final int cuotaNumero;
  final double? valorAbonado;
  final double valorCapital;
  final double valorInteres;
  final double valorCredito;
  final double interesPorcentaje;
  final String? fechaAbono;
  final Credit credito;

  factory CuotaCredito.fromJson(Map<String, dynamic> json) {
    return CuotaCredito(
      id: json['id'] as int,
      valorCuota: json['valorCuota'] as double,
      fechaCuota: json['fechaCuota'] as String,
      numeroCuotas: json['numeroCuotas'] as int,
      cuotaNumero: json['cuotaNumero'] as int,
      valorAbonado: json['valorAbonado'] as double,
      valorCapital: json['valorCapital'] as double,
      valorInteres: json['valorInteres'] as double,
      valorCredito: json['valorCredito'] as double,
      interesPorcentaje: json['interesPorcentaje'] as double,
      fechaAbono: json['fechaAbono'] as String,
      credito: Credit.fromJson(json['credito'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'valorCuota': valorCuota,
      'fechaCuota': fechaCuota,
      'numeroCuotas': numeroCuotas,
      'cuotaNumero': cuotaNumero,
      'valorAbonado': valorAbonado,
      'valorCapital': valorCapital,
      'valorInteres': valorInteres,
      'valorCredito': valorCredito,
      'interesPorcentaje': interesPorcentaje,
      'fechaAbono': fechaAbono,
      'credito': credito,
    };
  }
}
