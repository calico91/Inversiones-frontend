
import 'package:inversiones/src/domain/responses/user_response.dart';

abstract class UserDetailsRepository {
  const UserDetailsRepository();

  Future<UserDetailsResponse> get userDetails;
}
