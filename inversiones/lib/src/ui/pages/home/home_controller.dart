import 'dart:io';

import 'package:get/get.dart';
import 'package:inversiones/src/app_controller.dart';
import 'package:inversiones/src/data/http/client_http.dart';
import 'package:inversiones/src/data/local/secure_storage_local.dart';
import 'package:inversiones/src/domain/entities/client.dart';
import 'package:inversiones/src/domain/entities/user_details.dart';
import 'package:inversiones/src/domain/responses/all_clients_response.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class HomeController extends GetxController {
  HomeController(this.appController);

  final AppController appController;
  final UserDetails userDetails = Get.arguments as UserDetails;
  final RxBool _loading = RxBool(false);
  final Rx<List<Client>> _clients = Rx<List<Client>>([]);

  @override
  void onInit() {
    _load();
    super.onInit();
  }

  Future<void> _load() async {
    try {
      final AllClientsResponse allClientsResponse =
          await const ClientHttp().allClients;
      if (allClientsResponse.status == 200) {
        _clients(allClientsResponse.clients);
      } else {
        appController.manageError(allClientsResponse.message);
      }
    } on HttpException catch (e) {
      appController.manageError(e.message);
    } catch (e) {
      appController.manageError(e.toString());
    }
  }

  void logout() {
    Get.showOverlay(
      loadingWidget: Loading(),
      asyncFunction: () async {
        await const SecureStorageLocal().saveToken(null);
        Get.offAllNamed(RouteNames.signIn);
      },
    );
  }

  bool get loading => _loading.value;
  List<Client> get clients => _clients.value;
}
