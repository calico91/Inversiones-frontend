import 'dart:convert';

EstadoCreditoResponse estadoCreditoResponseFromJson(String str) {
  return EstadoCreditoResponse.fromJson(
    json.decode(str) as Map<String, dynamic>,
  );
}

class EstadoCreditoResponse {
  String? estadoCredito;
  String message;
  int status;

  EstadoCreditoResponse({
    this.estadoCredito,
    required this.message,
    required this.status,
  });

  factory EstadoCreditoResponse.fromJson(Map<String, dynamic> json) =>
      EstadoCreditoResponse(
        estadoCredito: json["data"] as String,
        message: json["message"] as String,
        status: json["status"] as int,
      );
}
