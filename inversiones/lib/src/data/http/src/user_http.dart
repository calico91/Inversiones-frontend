import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/user.dart';
import 'package:inversiones/src/domain/repositories/user_repository.dart';
import 'package:inversiones/src/domain/request/cambiar_contrasena_request.dart';
import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';

class UserHttp implements UserRepository {
  const UserHttp({this.baseHttpClient = const BaseHttpClient()});

  final BaseHttpClient baseHttpClient;

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

  @override
  Future<GenericoResponse> cambiarContrasena(
      CambiarContrasenaRequest cambiarContrasenaRequest) async {
    try {
      final http.Response response = await baseHttpClient.put(
          UrlPaths.cambiarContrasena,
          request: cambiarContrasenaRequest.toJson());
      return compute(genericoResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future <ApiResponse<User>> registrarUsuario(User user) async {
    try {
      final http.Response response = await baseHttpClient
          .post(UrlPaths.registrarUsuario, request: user.toJson());
      return compute(ApiResponse.parseUserResponse, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
