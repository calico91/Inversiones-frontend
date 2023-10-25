import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/cuota_credito.dart';

class Credit {
  const Credit({
    this.id,
    required this.estadoCredito,
    required this.fechaCredito,
    required this.cliente,
    required this.listaCuotasCredito,
  });

  final int? id;
  final String estadoCredito;
  final String fechaCredito;
  final Client cliente;
  final List<CuotaCredito> listaCuotasCredito;

  factory Credit.fromJson(Map<String, dynamic> json) {
    return Credit(
      id: json['id'] as int,
      estadoCredito: json['estadoCredito'] as String,
      fechaCredito: json['fechaCredito'] as String,
      cliente: Client.fromJson(json['cliente'] as Map<String, dynamic>),
      listaCuotasCredito: List<CuotaCredito>.from(
        (json['listaCuotasCredito'] as List<dynamic>).map((element) {
          return CuotaCredito.fromJson(element as Map<String, dynamic>);
        }),
      ),
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
