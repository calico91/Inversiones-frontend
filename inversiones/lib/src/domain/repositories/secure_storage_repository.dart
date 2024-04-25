import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';

abstract class SecureStorageRepository {
  const SecureStorageRepository();

  Future<String?> get jwtToken;
  Future<UserDetails?> get userDetails;
  Future<String?> get idMovil;
  Future<List<Client>?> get listaClientes;
  Future<String?> get usuarioBiometria;
  Future<void> saveToken(String? token);
  Future<void> saveUserDetails(UserDetails? userDetails);
  Future<void> saveIdMovil(String? password);
  Future<void> saveListaClientes(List<Client>? listaClientes);
  Future<void> saveUsuarioBiometria(String? usuarioBiometria);
}
