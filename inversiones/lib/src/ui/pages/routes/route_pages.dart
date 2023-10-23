import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_binding.dart';
import 'package:inversiones/src/ui/pages/clients/clients_page.dart';
import 'package:inversiones/src/ui/pages/home/home_binding.dart';
import 'package:inversiones/src/ui/pages/home/home_page.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_binding.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_page.dart';
import 'package:inversiones/src/ui/pages/splash/splash_binding.dart';
import 'package:inversiones/src/ui/pages/splash/splash_page.dart';

class RoutePages {
  const RoutePages._();
  static List<GetPage<dynamic>> get all {
    return [
      GetPage(
        name: RouteNames.home,
        page: () => const HomePage(),
        binding: const HomeBinding(),
      ),
      GetPage(
        name: RouteNames.signIn,
        page: () => const SignInPage(),
        binding: const SignInBinding(),
      ),
      GetPage(
        name: RouteNames.splash,
        page: () => const SplashPage(),
        binding: const SplashBinding(),
      ),
      GetPage(
        name: RouteNames.clients,
        page: () => const Clients(),
        binding: const ClientsBinding(),
      ),
      /*GetPage(
        name: RouteNames.employeeTask,
        page: () => const EmployeeTaskPage(),
        binding: const EmployeeTaskBinding(),
      ),
      GetPage(
        name: RouteNames.employeeAddTask,
        page: () => const EmployeeAddTaskPage(),
        binding: const EmployeeAddTaskBinding(),
      ), */
    ];
  }
}
