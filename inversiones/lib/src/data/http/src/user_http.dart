import 'dart:convert';

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
      return compute(genericoResponseFromJson, utf8.decode(response.bodyBytes));
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
      return compute(genericoResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<User>> registrarUsuario(User user) async {
    try {
      final http.Response response = await baseHttpClient
          .post(UrlPaths.registrarUsuario, request: user.toJson());
      return compute(
          ApiResponse.parseUserResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<User>>> consultarUsuarios() async {
    try {
      final http.Response response =
          await baseHttpClient.get(UrlPaths.consultarUsuarios);
      return compute(
          ApiResponse.parseUserListResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<User>> consultarUsuario(int id) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.consultarUsuario}/$id');
      return compute(
          ApiResponse.parseUserResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<User>> actualizarUsuario(User user) async {
    try {
      final http.Response response = await baseHttpClient
          .put(UrlPaths.actualizarUsuario, request: user.toJson());
      return compute(
          ApiResponse.parseUserResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String>> cambiarEstado(int id) async {
    try {
      final http.Response response =
          await baseHttpClient.put('${UrlPaths.cambiarEstado}/$id');
      return compute(
          ApiResponse.parseStringResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String>> reinicarContrasena(int id) async {
    try {
      final http.Response response =
          await baseHttpClient.put('${UrlPaths.reiniciarContrasena}/$id');
      return compute(
          ApiResponse.parseStringResponse, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }
}
