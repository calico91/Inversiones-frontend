import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/roles/consultar_roles_response.dart';

abstract class RolesRepository {
  const RolesRepository();

  Future<RolesResponse> consultarRoles();
  Future<ApiResponse<Roles>> consultarPermisosRol(int id);
  Future<ApiResponse<List<Permiso>>> consultarPermisos();
}
