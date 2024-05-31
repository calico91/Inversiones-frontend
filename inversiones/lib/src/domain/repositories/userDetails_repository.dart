import 'package:inversiones/src/domain/request/vincular_dispositivo_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';

abstract class UserdetailsRepository {
  const UserdetailsRepository();

  Future<GenericoResponse> vincularDispositivo(
      VincularDispositivoRequest vincularDispositivo);
}
