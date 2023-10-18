import 'package:inversiones/src/domain/responses/all_clients_response.dart';

abstract class ClientRepository {
  const ClientRepository();

  Future<AllClientsResponse> get allClients;
  //Future<AddEmployeeResponse> addEmployee(final Employee employee);
}
