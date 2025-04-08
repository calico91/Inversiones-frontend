import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/src/user_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/exceptions/http_exceptions.dart';
import 'package:inversiones/src/domain/request/cambiar_contrasena_request.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/animations/cargando_animacion.dart';
import 'package:inversiones/src/ui/pages/widgets/snackbars/info_snackbar.dart';

class CambiarContrasenaController extends GetxController {
  final AppController appController = Get.find<AppController>();

  final GlobalKey<FormState> formKeyCambiarContrasena = GlobalKey<FormState>();
  final TextEditingController contrasenaActual = TextEditingController();
  final TextEditingController contrasenaNueva = TextEditingController();
  final TextEditingController confirmarContrasena = TextEditingController();

  final RxBool ocultarContrasenaActual = true.obs;
  final RxBool ocultarContrasenaNueva = true.obs;
  final RxBool ocultarConfirmarContrasena = true.obs;

  Future<void> cambiarContrasena() async {
    final UserDetails? userDetails =
        await const SecureStorageLocal().userDetails;

    Get.showOverlay(
      loadingWidget: const CargandoAnimacion(),
      asyncFunction: () async {
        try {
          final GenericoResponse respuestaHttp =
              await const UserHttp().cambiarContrasena(
            CambiarContrasenaRequest(userDetails!.id!,
                contrasenaActual.text.trim(), contrasenaNueva.text.trim()),
          );
          await const SecureStorageLocal().saveToken(null);
          Get.offAllNamed(RouteNames.navigationBar);
          Get.showSnackbar(InfoSnackbar(respuestaHttp.data));
        } on HttpException catch (e) {
          appController.manageError(e.message);
        } catch (e) {
          appController.manageError(e.toString());
        }
      },
    );
  }
}
