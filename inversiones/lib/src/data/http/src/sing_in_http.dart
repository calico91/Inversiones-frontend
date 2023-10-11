import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/sing_in_repository.dart';
import 'package:inversiones/src/domain/responses/sing_in_response.dart';

class SignInHttp implements SignInRepository {
  const SignInHttp({
    this.baseHttpClient = const BaseHttpClient(),
  });

  final BaseHttpClient baseHttpClient;

  @override
  Future<SignInResponse> signInWithUsernameAndPassword(
    String username,
    String password,
  ) async {
    try {
      final http.Response response = await baseHttpClient.post(
        UrlPaths.signIn,
        request: {
          'username': username,
          'password': password,
        },
      );
      return compute(signInResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
