import 'package:inversiones/src/domain/entities/cliente.dart';
import 'package:inversiones/src/domain/entities/cuota_credito.dart';

class Credito {
  const Credito({
    this.id,
    required this.estadoCredito,
    required this.fechaCredito,
    required this.cliente,
    required this.listaCuotasCredito,
  });

  final int? id;
  final String estadoCredito;
  final String fechaCredito;
  final Cliente cliente;
  final List<CuotaCredito> listaCuotasCredito;

  factory Credito.fromJson(Map<String, dynamic> json) {
    return Credito(
      id: json['id'] as int,
      estadoCredito: json['estadoCredito'] as String,
      fechaCredito: json['fechaCredito'] as String,
      cliente: Cliente.fromJson(json['cliente'] as Map<String, dynamic>),
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
