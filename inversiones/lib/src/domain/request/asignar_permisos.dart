import 'package:inversiones/src/domain/entities/permiso.dart';

class AsignarPermisos {
  AsignarPermisos(this.idRol, this.permisos);

  int idRol;
  List<Permiso> permisos;

  Map<String, dynamic> toJson() => {'id_rol': idRol, 'permisos': permisos};
}
