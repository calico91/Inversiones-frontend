import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

    /* return _userDetails ??= _userDetails!
        .deserialize(await secureStorage.read(key: 'userDetails') ?? ''); */
  }
}
