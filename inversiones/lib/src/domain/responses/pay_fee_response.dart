import 'dart:convert';

PayFeeResponse payFeeResponseFromJson(String str) => PayFeeResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class PayFeeResponse {
  PayFee? payFee;
  String message;
  int status;

  PayFeeResponse({
    this.payFee,
    required this.message,
    required this.status,
  });

  factory PayFeeResponse.fromJson(Map<String, dynamic> json) => PayFeeResponse(
        payFee: json["data"] == null
            ? null
            : PayFee.fromJson(json["PayFee"] as Map<String, dynamic>),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class PayFee {
  int? id;
  double? valorCuota;
  String? fechaCuota;
  int? numeroCuotas;
  int? cuotaNumero;
  double? valorAbonado;
  double? valorCapital;
  double? valorInteres;
  double? valorCredito;
  double? interesPorcentaje;
  String? fechaAbono;

  PayFee({
    this.id,
    this.valorCuota,
    this.fechaCuota,
    this.numeroCuotas,
    this.cuotaNumero,
    this.valorAbonado,
    this.valorCapital,
    this.valorInteres,
    this.valorCredito,
    this.interesPorcentaje,
    this.fechaAbono,
  });

  factory PayFee.fromJson(Map<String, dynamic> json) => PayFee(
        id: json["id"] as int,
        valorCuota: json["valorCuota"] as double,
        fechaCuota: json["fechaCuota"] as String,
        numeroCuotas: json["numeroCuotas"] as int,
        cuotaNumero: json["cuotaNumero"] as int,
        valorAbonado:
            json["valorAbonado"] == null ? 0 : json["valorAbonado"] as double,
        valorCapital: json["valorCapital"] as double,
        valorInteres: json["valorInteres"] as double,
        valorCredito: json["valorCredito"] as double,
        interesPorcentaje: json["interesPorcentaje"] as double,
        fechaAbono:
            json["fechaAbono"] == null ? null : json["fechaAbono"] as String,
      );
}
