import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/responses/add_client_response.dart';
import 'package:inversiones/src/domain/responses/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clients_pending_installments_response.dart';

abstract class ClientRepository {
  const ClientRepository();

  Future<AllClientsResponse> allClients(String clientesCreditosActivos);
  Future<AddClientResponse> loadClient(String document);
  Future<AddClientResponse> updateClient(int id, Client client);
  Future<AddClientResponse> addClient(Client client);
  Future<ClientsPendingInstallmentsResponse> clientsPendingInstallments();
}
