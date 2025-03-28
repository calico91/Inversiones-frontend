import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/repositories/roles_repository.dart';
import 'package:inversiones/src/domain/request/asignar_permisos.dart';
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
      return compute(consultarRolesResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Roles>> consultarPermisosRol(int id) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.consultarPermisosRol}/$id');
      return compute(ApiResponse.parseRoles, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<Permiso>>> consultarPermisos() async {
    try {
      final http.Response response =
          await baseHttpClient.get(UrlPaths.consultarPermisos);
      return compute(ApiResponse.parsePermisoListResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String>> asignarPermisos(
      AsignarPermisos asignarPermisos) async {
    try {
      final http.Response response = await baseHttpClient
          .put(UrlPaths.asignarPermisos, request: asignarPermisos.toJson());
      return compute(ApiResponse.parseStringResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }
}
