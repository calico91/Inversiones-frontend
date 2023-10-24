import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/repositories/client_repository.dart';
import 'package:inversiones/src/domain/responses/add_client_response.dart';
import 'package:inversiones/src/domain/responses/all_clients_response.dart';

class ClientHttp implements ClientRepository {
  const ClientHttp({
    this.baseHttpClient = const BaseHttpClient(),
  });

  final BaseHttpClient baseHttpClient;

  @override
  Future<AddClientResponse> addClient(Client client) async {
    try {
      final http.Response response = await baseHttpClient
          .post(UrlPaths.addClient, request: client.toJson());
      return compute(addClientResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllClientsResponse> allClients(String clientesCreditosActivos) async {
    try {
      final http.Response response = await baseHttpClient.get(
        "${UrlPaths.allClients}/$clientesCreditosActivos",
      );

      return compute(allClientsResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
