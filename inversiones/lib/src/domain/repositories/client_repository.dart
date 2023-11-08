import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/responses/clientes/add_client_response.dart';
import 'package:inversiones/src/domain/responses/clientes/all_clients_response.dart';
import 'package:inversiones/src/domain/responses/clientes/clients_pending_installments_response.dart';

abstract class ClientRepository {
  const ClientRepository();

  Future<AllClientsResponse> allClients();
  Future<AddClientResponse> loadClient(String document);
  Future<AddClientResponse> updateClient(int id, Client client);
  Future<AddClientResponse> addClient(Client client);

  /// clientes con cuotas pendientes
  Future<ClientsPendingInstallmentsResponse> clientsPendingInstallments();
}
