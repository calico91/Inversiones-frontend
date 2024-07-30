import 'package:inversiones/src/domain/responses/roles/consultar_roles_response.dart';

abstract class RolesRepository {
  const RolesRepository();

  Future<RolesResponse> consultarRoles();
}
