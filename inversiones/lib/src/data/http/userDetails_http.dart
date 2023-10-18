import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/userDetails_repository.dart';
import 'package:inversiones/src/domain/responses/user_response.dart';

class UserDetailsHttp implements UserDetailsRepository {
  const UserDetailsHttp({
    this.baseHttpClient = const BaseHttpClient(),
  });

  final BaseHttpClient baseHttpClient;

  @override
  Future<UserDetailsResponse> get userDetails async {
    try {
      final http.Response response = await baseHttpClient.get(
        UrlPaths.getUser,
      );
      return compute(userDetailsResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
