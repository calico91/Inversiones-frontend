import 'dart:convert';

ReporteInteresyCapitalResponse reporteInteresyCapitalResponseFromJson(
  String str,
) =>
    ReporteInteresyCapitalResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class ReporteInteresyCapitalResponse {
  final ReporteInteresyCapital? reporteInteresyCapital;
  final String? message;
  final int? status;

  ReporteInteresyCapitalResponse({
    this.reporteInteresyCapital,
    this.message,
    this.status,
  });

  factory ReporteInteresyCapitalResponse.fromJson(Map<String, dynamic> json) =>
      ReporteInteresyCapitalResponse(
        reporteInteresyCapital: ReporteInteresyCapital.fromJson(
          json["data"] as Map<String, dynamic>,
        ),
        message: json["message"] as String,
        status: json["status"] as int,
      );
}

class ReporteInteresyCapital {
  final double? interesMes;
  final double? capitalMes;

  ReporteInteresyCapital({
    this.interesMes,
    this.capitalMes,
  });

  factory ReporteInteresyCapital.fromJson(Map<String, dynamic> json) =>
      ReporteInteresyCapital(
        interesMes: json["interesMes"] as double,
        capitalMes: json["capitalMes"] as double,
      );
}
