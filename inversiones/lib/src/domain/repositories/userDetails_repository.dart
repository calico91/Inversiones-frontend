import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/domain/responses/user_response.dart';

abstract class UserDetailsRepository {
  const UserDetailsRepository();

  Future<UserDetailsResponse> get userDetails;
  Future<GenericoResponse> vincularDispositivo(
      VincularDispositivoRequest vincularDispositivo);
}
