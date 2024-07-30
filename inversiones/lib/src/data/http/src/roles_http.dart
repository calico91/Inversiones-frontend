import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/roles_repository.dart';
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
}
