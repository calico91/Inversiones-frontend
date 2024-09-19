import 'package:inversiones/src/domain/entities/permiso.dart';

class Roles {
  const Roles({required this.id, required this.name, this.permisos});

  final int id;
  final String name;
  final List<Permiso>? permisos;

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
      id: json['id'] as int,
      name: json['name'] as String,
      permisos: json['permisos'] == null
          ? List.empty()
          : List<Permiso>.from(
              (json['permisos'] as List<dynamic>).map((element) {
              return Permiso.fromJson(element as Map<String, dynamic>);
            })));

  Map<String, dynamic> toJson() {
    return {if (id != 0) 'id': id, 'name': name};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Roles && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
