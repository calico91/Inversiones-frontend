class Permiso {
  const Permiso(
      {required this.id, required this.descripcion, required this.endpoint});

  final int id;
  final String descripcion;
  final String? endpoint;

  factory Permiso.fromJson(Map<String, dynamic> json) => Permiso(
        id: json['id'] as int,
        descripcion: json['descripcion'] as String,
        endpoint: json['endpoint'] != null ? json['endpoint'] as String : null,
      );

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'descripcion': descripcion,
      'endpoint': endpoint
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Permiso &&
        other.id == id &&
        other.descripcion == descripcion &&
        other.endpoint == endpoint;
  }

  @override
  int get hashCode => id.hashCode ^ descripcion.hashCode ^ endpoint.hashCode;
}
