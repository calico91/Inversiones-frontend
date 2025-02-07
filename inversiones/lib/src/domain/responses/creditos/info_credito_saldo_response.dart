import 'dart:convert';

InfoCreditoySaldoResponse infoCreditoySaldoResponseFromJson(String str) =>
    InfoCreditoySaldoResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class InfoCreditoySaldoResponse {
  InfoCreditoySaldo? infoCreditoySaldo;
  String? message;
  int? status;

  InfoCreditoySaldoResponse({
    this.infoCreditoySaldo,
    this.message,
    this.status,
  });

  factory InfoCreditoySaldoResponse.fromJson(Map<String, dynamic> json) =>
      InfoCreditoySaldoResponse(
        infoCreditoySaldo: json["data"] == null
            ? null
            : InfoCreditoySaldo.fromJson(json["data"] as Map<String, dynamic>),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class InfoCreditoySaldo {
  int? idCredito;
  int? id;
  double? valorCuota;
  String? fechaCuota;
  int? numeroCuotas;
  int? cuotaNumero;
  double? valorInteres;
  double? valorCredito;
  double? interesPorcentaje;
  String? fechaCredito;
  double? interesHoy;
  double? saldoCredito;
  double? capitalPagado;
  String? ultimaCuotaPagada;
  double? interesMora;
  String? modalidad;
  double? saldoCapital;

  InfoCreditoySaldo(
      {this.idCredito,
      this.id,
      this.valorCuota,
      this.fechaCuota,
      this.numeroCuotas,
      this.cuotaNumero,
      this.valorInteres,
      this.valorCredito,
      this.interesPorcentaje,
      this.fechaCredito,
      this.interesHoy,
      this.saldoCredito,
      this.capitalPagado,
      this.ultimaCuotaPagada,
      this.interesMora,
      this.modalidad,
      this.saldoCapital});

  factory InfoCreditoySaldo.fromJson(Map<String, dynamic> json) =>
      InfoCreditoySaldo(
        id: json["id"] as int,
        valorCuota: json["valorCuota"] as double,
        fechaCuota: json["fechaCuota"] as String,
        numeroCuotas: json["numeroCuotas"] as int,
        cuotaNumero: json["cuotaNumero"] as int,
        valorInteres: json["valorInteres"] as double,
        valorCredito: json["valorCredito"] as double,
        interesPorcentaje: json["interesPorcentaje"] as double,
        fechaCredito: json["fechaCredito"] as String,
        interesHoy: json["interesHoy"] as double,
        saldoCredito: json["saldoCredito"] as double,
        capitalPagado: json["capitalPagado"] as double,
        ultimaCuotaPagada: json["ultimaCuotaPagada"] as String,
        interesMora: json["interesMora"] as double,
        modalidad: json["modalidad"] as String,
        saldoCapital: json["saldoCapital"] as double,
      );
}
