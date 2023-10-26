import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/cuota_credito.dart';

class Credit {
  const Credit({
    this.id,
    this.estadoCredito,
    required this.fechaCredito,
    this.cliente,
    this.listaCuotasCredito,
  });

  final int? id;
  final String? estadoCredito;
  final String fechaCredito;
  final Client? cliente;
  final List<CuotaCredito>? listaCuotasCredito;

  factory Credit.fromJson(Map<String, dynamic> json) {
    return Credit(
      id: json['id'] as int,
      estadoCredito: json['estadoCredito'] != null
          ? json['estadoCredito'] as String
          : null,
      fechaCredito: json['fechaCredito'] as String,
      cliente: json['cliente'] != null
          ? Client.fromJson(json['cliente'] as Map<String, dynamic>)
          : null,
      listaCuotasCredito: json['listaCuotasCredito'] != null
          ? List<CuotaCredito>.from(
              (json['listaCuotasCredito'] as List<dynamic>).map((element) {
                return CuotaCredito.fromJson(element as Map<String, dynamic>);
              }),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'estadoCredito': estadoCredito,
      'fechaCredito': fechaCredito,
      'cliente': cliente,
    };
  }
}
