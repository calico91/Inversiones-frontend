import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/repositories/secure_storage_repository.dart';

class SecureStorageLocal implements SecureStorageRepository {
  const SecureStorageLocal({this.secureStorage = const FlutterSecureStorage()});

  final FlutterSecureStorage secureStorage;

  static String? _jwtToken;

  static UserDetails? _userDetails;

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
  Future<void> saveUserDetails(UserDetails? userDetails) {
    return secureStorage.write(
        key: 'userDetails', value: _userDetails.toString());
  }

  @override
  Future<UserDetails?> get userDetails async {
    return _userDetails ??=
        (await secureStorage.read(key: 'userDetails')) as UserDetails?;
  }
}
