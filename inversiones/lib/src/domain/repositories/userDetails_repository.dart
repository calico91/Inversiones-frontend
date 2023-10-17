
import 'package:inversiones/src/domain/responses/user_response.dart';

abstract class UserDetailsRepository {
  const UserRepository();

  Future<UserResponse> get user;
}
