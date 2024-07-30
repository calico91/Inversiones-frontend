import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/roles_http.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/roles/consultar_roles_response.dart';

class RolesController extends GetxController {
  final AppController appController = Get.find<AppController>();
  Rx<List<Roles>> roles = Rx<List<Roles>>([]);
  RxBool cargando = false.obs;

  Future<void> consultarRoles([String? fechaFiltro]) async {
    try {
      cargando(true);
      final RolesResponse resHTTP = await const RolesHttp().consultarRoles();
      roles(resHTTP.roles);
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    } finally {
      cargando(false);
    }
  }
}
