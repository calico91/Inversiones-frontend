import 'package:inversiones/src/domain/request/cambiar_contrasena_request.dart';
import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';

abstract class UserRepository {
  const UserRepository();

  Future<GenericoResponse> vincularDispositivo(
      VincularDispositivoRequest vincularDispositivoRequest);

  Future<GenericoResponse> cambiarContrasena(
      CambiarContrasenaRequest cambiarContrasenaRequest);
}
