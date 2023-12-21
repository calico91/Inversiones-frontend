import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/repositories/client_repository.dart';
import 'package:inversiones/src/domain/responses/clientes/add_client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';

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

  /// consulta los clientes que tienen creditos activos o todos los clientes.
  /// T creditos activos F todos los clientes.
  @override
  Future<AllClientsResponse> allClients( ) async {
    try {
      final http.Response response = await baseHttpClient.get(
        UrlPaths.allClients,
      );

      return compute(allClientsResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddClientResponse> loadClient(String document) async {
    try {
      final http.Response response = await baseHttpClient.get(
        "${UrlPaths.loadClient}/$document",
      );

      return compute(addClientResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddClientResponse> updateClient(int id, Client client) async {
    try {
      final http.Response response = await baseHttpClient
          .put("${UrlPaths.updateClient}/$id", request: client.toJson());

      return compute(addClientResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  ///consulta informacion de los clientes que tienen cuotas pendientes
  ///de la fecha actual hacia atras
  @override
  Future<ClientsPendingInstallmentsResponse>
      clientsPendingInstallments(String fechaFiltro ) async {
    try {
      final http.Response response = await baseHttpClient.get(
       ' ${UrlPaths.infoClientesCuotaCredito}/$fechaFiltro',
      );

      return compute(clientsPendingInstallmentsResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
