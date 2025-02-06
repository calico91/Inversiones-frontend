import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/responses/api_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clientes/client_images_response.dart';
import 'package:inversiones/src/domain/responses/clientes/client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';
import 'package:inversiones/src/domain/responses/clientes/imagenes_cliente_response.dart';

abstract class ClientRepository {
  const ClientRepository();

  Future<AllClientsResponse> allClients();
  Future<ClientResponse> loadClient(String document);
  Future<ClientResponse> updateClient(int id, Client client);
  Future<ClientResponse> addClient(Client client);

  /// clientes con cuotas pendientes
  Future<ClientsPendingInstallmentsResponse> clientsPendingInstallments(
      String fechaFiltro, int idUsuario);

  Future<ApiResponse<List<ImagenCliente>>> consultarImagenes(int idCliente);

  Future<ClientImagesResponse> consultarClienteImagenes(int id);
}
