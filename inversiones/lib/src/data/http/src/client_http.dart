import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/repositories/client_repository.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clientes/client_images_response.dart';
import 'package:inversiones/src/domain/responses/clientes/client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';
import 'package:inversiones/src/domain/responses/clientes/imagenes_cliente_response.dart';

class ClientHttp implements ClientRepository {
  const ClientHttp({this.baseHttpClient = const BaseHttpClient()});

  final BaseHttpClient baseHttpClient;

  @override
  Future<ClientResponse> addClient(Client client) async {
    try {
      final cliente = {'cliente': jsonEncode(client.toJson())};

      final http.Response response = await baseHttpClient.Multipart(
          UrlPaths.addClient, cliente, client.imagenes, 'POST');

      return compute(
          addClientResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  /// consulta los clientes que tienen creditos activos o todos los clientes.
  /// T creditos activos F todos los clientes.
  @override
  Future<AllClientsResponse> allClients() async {
    try {
      final http.Response response =
          await baseHttpClient.get(UrlPaths.allClients);

      return compute(
          allClientsResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClientResponse> loadClient(String document) async {
    try {
      final http.Response response = await baseHttpClient.get(
        "${UrlPaths.loadClient}/$document",
      );

      return compute(
          addClientResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClientResponse> updateClient(int id, Client client) async {
    try {
      final cliente = {'cliente': jsonEncode(client.toJson())};

      final http.Response response = await baseHttpClient.Multipart(
          "${UrlPaths.updateClient}/$id", cliente, client.imagenes, 'PUT');

      return compute(
          addClientResponseFromJson, utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  ///consulta informacion de los clientes que tienen cuotas pendientes
  ///de la fecha actual hacia atras
  @override
  Future<ClientsPendingInstallmentsResponse> clientsPendingInstallments(
      String fechaFiltro, int idUsuario) async {
    try {
      final http.Response response = await baseHttpClient.get(
        '${UrlPaths.consultarCuotasPorFecha}/$fechaFiltro/$idUsuario',
      );

      return compute(clientsPendingInstallmentsResponseFromJson,
          utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<ImagenCliente>>> consultarImagenes(
      int idCliente) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.consultarImagenes}/$idCliente');

      return compute(ApiResponse.parseimagenesClienteResponse,
          utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClientImagesResponse> consultarClienteImagenes(int id) async {
    try {
      final http.Response response = await baseHttpClient.get(
        "${UrlPaths.consultarClienteImagenes}/$id",
      );

      return compute(clientImagesResponseResponseFromJson,
          utf8.decode(response.bodyBytes));
    } catch (e) {
      rethrow;
    }
  }
}
