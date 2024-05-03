import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_controller.dart';

class UsersBinding implements Bindings {
  const UsersBinding();

  @override
  void dependencies() {
    Get.lazyPut<ClientsController>(
      () => ClientsController(),
    );
  }
}
