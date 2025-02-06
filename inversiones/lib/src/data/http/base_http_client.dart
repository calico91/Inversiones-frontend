import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/ui/pages/utils/constantes.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class BaseHttpClient {
  const BaseHttpClient(
      {this.timeout = const Duration(seconds: 15),
      this.secureStorageLocal = const SecureStorageLocal()});

  final Duration timeout;
  final SecureStorageLocal secureStorageLocal;

  Future<http.Response> get(String path,
      [Map<String, String>? parameters]) async {
    final String url = await secureStorageLocal.urlServidor ?? '';
    final Uri uri = parameters == null
        ? Uri.http(url, path)
        : Uri.http(url, path, parameters);

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
      throw FetchDataException(
          Constantes.ERROR_INTERNET_SERVIDOR, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Error de comunicación, intente nuevamente.', uri.toString());
    }
  }

  Future<http.Response> post(String path,
      {Map<String, dynamic>? request, Map<String, String>? parameters}) async {
    final String url = await secureStorageLocal.urlServidor ?? '';
    final Uri uri = parameters == null
        ? Uri.http(url, path)
        : Uri.http(url, path, parameters);

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
      throw FetchDataException(
          Constantes.ERROR_INTERNET_SERVIDOR, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Error de comunicacion, intente nuevamente.', uri.toString());
    }
  }

  Future<http.Response> put(String path,
      {Map<String, dynamic>? request, Map<String, String>? parameters}) async {
    final String url = await secureStorageLocal.urlServidor ?? '';
    final Uri uri = parameters == null
        ? Uri.http(url, path)
        : Uri.http(url, path, parameters);
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
      throw FetchDataException(
          Constantes.ERROR_INTERNET_SERVIDOR, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Error de comunicación, intente nuevamente.', uri.toString());
    }
  }

  Future<http.Response> Multipart(String path, Map<String, String> fields,
      Iterable<ImageFile>? imagenes, String metodoHTTP) async {
    final String url = await secureStorageLocal.urlServidor ?? '';
    final Uri uri = Uri.http(url, path);
    try {
      final String? token = await secureStorageLocal.jwtToken;
      final request = http.MultipartRequest(metodoHTTP, uri);
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
      if (imagenes != null && imagenes.isNotEmpty) {
        for (final file in imagenes) {
          request.files
              .add(await http.MultipartFile.fromPath('imagenes', file.path!));
        }
      }
      request.headers[HttpHeaders.authorizationHeader] = token ?? '';
      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return Future.value(response);
      } else {
        final message = jsonDecode(response.body);
        throw _processResponse(
          response.statusCode,
          response.request?.url.toString() ?? uri.toString(),
          // ignore: avoid_dynamic_calls
          message['message'].toString(),
        );
      }
    } on SocketException {
      throw FetchDataException(
          Constantes.ERROR_INTERNET_SERVIDOR, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Error de comunicación, intente nuevamente.', uri.toString());
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
