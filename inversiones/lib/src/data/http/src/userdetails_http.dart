import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/userdetails_repository.dart';
import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/domain/responses/user_response.dart';

class UserDetailsHttp implements UserDetailsRepository {
  const UserDetailsHttp({this.baseHttpClient = const BaseHttpClient()});

  final BaseHttpClient baseHttpClient;

  @override
  Future<UserDetailsResponse> get userDetails async {
    try {
      final http.Response response = await baseHttpClient.get(UrlPaths.getUser);
      return compute(userdetailsResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenericoResponse> vincularDispositivo(
      VincularDispositivoRequest vincularDispositivo) async {
    try {
      final http.Response response = await baseHttpClient.post(
          UrlPaths.vincularDispositivo,
          request: vincularDispositivo.toJson());
      return compute(genericoResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
