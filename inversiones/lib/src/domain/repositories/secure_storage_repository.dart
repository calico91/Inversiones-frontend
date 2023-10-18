import 'package:inversiones/src/domain/entities/user_details.dart';

abstract class SecureStorageRepository {
  const SecureStorageRepository();

  Future<String?> get jwtToken;
  Future<UserDetails?> get userDetails;
  Future<void> saveToken(String? token);
  Future<void> saveUserDetails(UserDetails? userDetails);
}
