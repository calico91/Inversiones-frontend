import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';

class BaseHttpClient {
  const BaseHttpClient(
      {this.timeout = const Duration(seconds: 15),
      this.secureStorageLocal = const SecureStorageLocal()});

  final Duration timeout;
  final SecureStorageLocal secureStorageLocal;

  Future<http.Response> get(String path,
      [Map<String, String>? parameters]) async {
    final Uri uri = parameters == null
        ? Uri.parse('${UrlPaths.urlHTTP}$path')
        : Uri.https(UrlPaths.url, path, parameters);


    try {
      final String? token = await secureStorageLocal.jwtToken;
      final http.Response response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: token ?? ''
      }).timeout(timeout);
      if (response.statusCode == 200) {
        return Future.value(response);
      }
      final message = jsonDecode(response.body);
      throw _processResponse(
        response.statusCode,
        response.request?.url.toString() ?? uri.toString(),
        // ignore: avoid_dynamic_calls
        message['message'].toString(),
      );
    } on SocketException {
      throw FetchDataException('No tiene conexión a internet.', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Error de comunicación, intente nuevamente.', uri.toString());
    }
  }

  Future<http.Response> post(String path,
      {Map<String, dynamic>? request, Map<String, String>? parameters}) async {
    final Uri uri = parameters == null
        ? Uri.parse('${UrlPaths.urlHTTP}$path')
        : Uri.https(UrlPaths.url, path, parameters);
    try {
      final String? token = await secureStorageLocal.jwtToken;
      final response = await http
          .post(uri,
              headers:
                  path == UrlPaths.signIn || path == UrlPaths.authBiometrica
                      ? {
                          HttpHeaders.authorizationHeader: Constantes.NO_TOKEN,
                          HttpHeaders.contentTypeHeader: 'application/json'
                        }
                      : {
                          HttpHeaders.authorizationHeader: token ?? '',
                          HttpHeaders.contentTypeHeader: 'application/json'
                        },
              body: request != null ? json.encode(request) : null)
          .timeout(timeout);
      if (response.statusCode == 200) {
        return Future.value(response);
      }
      final message = jsonDecode(response.body);
      throw _processResponse(
        response.statusCode,
        response.request?.url.toString() ?? uri.toString(),
        // ignore: avoid_dynamic_calls
        message['message'].toString(),
      );
    } on SocketException {
      throw FetchDataException('No tiene conexion a internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Error de comunicacion, intente nuevamente.', uri.toString());
    }
  }

  Future<http.Response> put(String path,
      {Map<String, dynamic>? request, Map<String, String>? parameters}) async {
    final Uri uri = parameters == null
        ? Uri.parse('${UrlPaths.urlHTTP}$path')
        : Uri.https(UrlPaths.url, path, parameters);
    try {
      final String? token = await secureStorageLocal.jwtToken;
      final response = await http
          .put(
            uri,
            headers: path == UrlPaths.signIn || path == UrlPaths.authBiometrica
                      ? {
                          HttpHeaders.authorizationHeader: Constantes.NO_TOKEN,
                          HttpHeaders.contentTypeHeader: 'application/json'
                        }
                      : {
                          HttpHeaders.authorizationHeader: token ?? '',
                          HttpHeaders.contentTypeHeader: 'application/json'
                        },
            body: request != null ? json.encode(request) : null,
          )
          .timeout(timeout);
      if (response.statusCode == 200) {
        return Future.value(response);
      }
      final message = jsonDecode(response.body);
      throw _processResponse(
          response.statusCode,
          response.request?.url.toString() ?? uri.toString(),
          // ignore: avoid_dynamic_calls
          message['message'].toString());
    } on SocketException {
      throw FetchDataException('No tiene conexión a internet.', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Error de comunicación, intente nuevamente.', uri.toString());
    }
  }

  Exception _processResponse(int statusCode, String url, [String? message]) {
    switch (statusCode) {
      case 400:
        return BadRequestException(
          message ?? 'Check request sent to server',
          url,
        );
      case 401:
        return UnauthorizedException(
          message ?? 'Your credentials are incorrect',
          url,
        );
      case 403:
        return UnauthorizedException(
          message ?? 'You do not have authorization',
          url,
        );
      default:
        return FetchDataException(
          message ?? 'Error ocurred with code: $statusCode',
          url,
        );
    }
  }
}
