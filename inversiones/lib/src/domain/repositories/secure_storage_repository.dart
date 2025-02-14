import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';

abstract class SecureStorageRepository {
  const SecureStorageRepository();

  Future<String?> get jwtToken;
  Future<UserDetails?> get userDetails;
  Future<String?> get idMovil;
  Future<List<Client>?> get listaClientes;
  Future<String?> get usuarioBiometria;
  Future<String?> get urlServidor;
  Future<List<Roles>?> get roles;
  Future<List<Permiso>?> get permisos;
  Future<String?> get consularApp;
  Future<String?> get diasMora;
  Future<String?> get valorMora;
  Future<void> saveToken(String? token);
  Future<void> saveUserDetails(UserDetails? userDetails);
  Future<void> saveIdMovil(String? password);
  Future<void> saveListaClientes(List<Client>? listaClientes);
  Future<void> saveUsuarioBiometria(String? usuarioBiometria);
  Future<void> saveUrlServidor(String? urlServidor);
  Future<void> saveRoles(List<Roles>? roles);
  Future<void> savePermisos(List<Permiso>? roles);
  Future<void> saveConsultarApp(String? consularApp);
  Future<void> saveDiasMora(String? diasMora);
  Future<void> saveValorMora(String? valorMora);
}
