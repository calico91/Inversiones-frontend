import 'package:inversiones/src/domain/responses/all_clients_response.dart';

abstract class ClientRepository {
  const ClientRepository();

  Future<AllClientsResponse>  allClients(String clientesCreditosActivos);
  //Future<AddEmployeeResponse> addEmployee(final Employee employee);
}
