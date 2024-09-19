import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/repositories/roles_repository.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/roles/consultar_roles_response.dart';

class RolesHttp implements RolesRepository {
  const RolesHttp({this.baseHttpClient = const BaseHttpClient()});

  final BaseHttpClient baseHttpClient;

  @override
  Future<RolesResponse> consultarRoles() async {
    try {
      final http.Response response =
          await baseHttpClient.get(UrlPaths.consultarRoles);
      return compute(consultarRolesResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Roles>> consultarPermisosRol(int id) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.consultarPermisosRol}/$id');
      return compute(ApiResponse.parseRoles, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
