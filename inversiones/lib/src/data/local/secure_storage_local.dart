import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/repositories/secure_storage_repository.dart';

class SecureStorageLocal implements SecureStorageRepository {
  const SecureStorageLocal({this.secureStorage = const FlutterSecureStorage()});

  final FlutterSecureStorage secureStorage;

  static String? _jwtToken;

  @override
  Future<String?> get jwtToken async {
    return _jwtToken ??= await secureStorage.read(key: 'jwtToken');
  }

  @override
  Future<void> saveToken(String? token) {
    _jwtToken = token == null ? null : 'Bearer $token';
    return secureStorage.write(key: 'jwtToken', value: _jwtToken);
  }

  @override
  Future<void> saveUserDetails(UserDetails? userDetails) async {
    return secureStorage.write(
      key: 'userDetails',
      value: jsonEncode(userDetails!.toJson()),
    );
  }

  @override
  Future<UserDetails?> get userDetails async {
    final user = await secureStorage.read(key: 'userDetails');
    if (user?.isNotEmpty ?? false) {
      return UserDetails.fromJson(jsonDecode(user!) as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<String?> get idMovil async => await secureStorage.read(key: 'idMovil');

  @override
  Future<void> saveIdMovil(String? idMovil) =>
      secureStorage.write(key: 'idMovil', value: idMovil);

  @override
  Future<void> saveListaClientes(List<Client>? listaClientes) async {
    return secureStorage.write(
        key: 'listaClientes',
        value: jsonEncode(
            listaClientes?.map((cliente) => cliente.toJson()).toList()));
  }

  @override
  Future<List<Client>> get listaClientes async {
    final listaClientesJson = await secureStorage.read(key: 'listaClientes');
    if (listaClientesJson != null || (listaClientesJson?.isNotEmpty ?? false)) {
      final List<dynamic> objetosList =
          jsonDecode(listaClientesJson!) as List<dynamic>;
      return objetosList
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<void> saveUsuarioBiometria(String? usuarioBiometria) =>
      secureStorage.write(key: 'usuarioBiometria', value: usuarioBiometria);

  @override
  Future<String?> get usuarioBiometria async =>
      await secureStorage.read(key: 'usuarioBiometria');

  @override
  Future<void> saveUrlServidor(String? urlServidor) => secureStorage.write(
      key: 'urlServidor', value: urlServidor?.replaceAll(' ', ''));

  @override
  Future<String?> get urlServidor async =>
      await secureStorage.read(key: 'urlServidor');

  @override
  Future<void> saveRoles(List<Roles>? roles) async {
    return secureStorage.write(
        key: 'roles',
        value: jsonEncode(roles?.map((roles) => roles.toJson()).toList()));
  }

  @override
  Future<List<Roles>?> get roles async {
    final rolesJson = await secureStorage.read(key: 'roles');
    if (rolesJson != null || (rolesJson?.isNotEmpty ?? false)) {
      final List<dynamic>? objetosList =
          jsonDecode(rolesJson ?? '') as List<dynamic>?;
      return objetosList
          ?.map((e) => Roles.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<void> savePermisos(List<Permiso>? permisos) async {
    return secureStorage.write(
        key: 'permisos',
        value: jsonEncode(
            permisos?.map((permisos) => permisos.toJson()).toList()));
  }

  @override
  Future<List<Permiso>?> get permisos async {
    final permisosJson = await secureStorage.read(key: 'permisos');
    if (permisosJson != null || (permisosJson?.isNotEmpty ?? false)) {
      final List<dynamic>? objetosList =
          jsonDecode(permisosJson ?? '') as List<dynamic>?;
      return objetosList
          ?.map((e) => Permiso.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<String?> get consularApp async =>
      await secureStorage.read(key: 'consultarApp');

  @override
  Future<void> saveConsultarApp(String? consularApp) =>
      secureStorage.write(key: 'consultarApp', value: consularApp);
}
