import 'package:inversiones/src/domain/responses/sing_in_response.dart';

abstract class SignInRepository {
  const SignInRepository();

  Future<SignInResponse> signInWithUsernameAndPassword(
    String username,
    String password,
  );
}
