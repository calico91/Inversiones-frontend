class VincularDispositivoRequest {
  const VincularDispositivoRequest({
    required this.username,
    required this.idDispositivo,
  });

  final String username;
  final String idDispositivo;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'idDispositivo': idDispositivo,
    };
  }
}
