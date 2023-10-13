
import 'package:inversiones/src/domain/responses/user_response.dart';

abstract class UserRepository {
  const UserRepository();

  Future<UserResponse> get user;
}
