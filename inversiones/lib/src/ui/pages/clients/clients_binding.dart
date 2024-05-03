import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';

class ClientsBinding implements Bindings {
  const ClientsBinding();

  @override
  void dependencies() {
    Get.lazyPut<ClientsController>(
      () => ClientsController(),
    );
  }
}
