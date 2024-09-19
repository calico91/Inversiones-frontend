import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/roles_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/responses/roles/consultar_roles_response.dart';

class RolesController extends GetxController {
  final AppController appController = Get.find<AppController>();
  Rx<List<Roles>> roles = Rx<List<Roles>>([]);
  RxBool cargando = false.obs;
  int statusHttp = 0;
  SecureStorageLocal secureStorageLocal = const SecureStorageLocal();
  RxString rolSeleccionado = ''.obs;

   @override
  Future<void> onInit() async {
    await consultarRoles();

    super.onInit();
  }

  Future<void> consultarRoles() async {
    try {
      cargando(true);
      final List<Roles>? rolesStorage = await secureStorageLocal.roles;

      if (rolesStorage?.isEmpty ?? true) {
        final RolesResponse resHTTP = await const RolesHttp().consultarRoles();
        await secureStorageLocal.saveRoles(resHTTP.roles);
      }
      statusHttp = 200;
      roles(rolesStorage);

    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    } finally {
      cargando(statusHttp != 200);
    }
  }
}
