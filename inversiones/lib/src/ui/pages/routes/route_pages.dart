import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/clients/clients_binding.dart';
import 'package:inversiones/src/ui/pages/clients/clients_page.dart';
import 'package:inversiones/src/ui/pages/credits/credits_binding.dart';
import 'package:inversiones/src/ui/pages/credits/credits_page.dart';
import 'package:inversiones/src/ui/pages/home/home_binding.dart';
import 'package:inversiones/src/ui/pages/home/home_page.dart';
import 'package:inversiones/src/ui/pages/navigation_bar/navigation_bar_binding.dart';
import 'package:inversiones/src/ui/pages/navigation_bar/navigation_bar_page.dart';
import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_binding.dart';
import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_page.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_binding.dart';
import 'package:inversiones/src/ui/pages/reportes/reportes_page.dart';
import 'package:inversiones/src/ui/pages/roles/roles_page.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_binding.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_page.dart';
import 'package:inversiones/src/ui/pages/splash/splash_binding.dart';
import 'package:inversiones/src/ui/pages/splash/splash_page.dart';
import 'package:inversiones/src/ui/pages/users/users_page.dart';

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
        page: () => const ClientsPage(),
        binding: const ClientsBinding(),
      ),
      GetPage(
        name: RouteNames.credits,
        page: () => const CreditsPage(),
        binding: const CreditsBinding(),
      ),
      GetPage(
        name: RouteNames.payFee,
        page: () => PayFeePage(),
        binding: const PayFeeBinding(),
      ),
      GetPage(
        name: RouteNames.reportes,
        page: () => ReportesPage(),
        binding: const ReportesBinding(),
      ),
      GetPage(
        name: RouteNames.users,
        page: () => UsersPage(),
      ),
      GetPage(
        name: RouteNames.navigationBar,
        page: () => NavigatinBarPage(),
        binding: const NavigationBarBinding(),
      ),
        GetPage(
        name: RouteNames.roles,
        page: () => RolesPage(),
      ),
    ];
  }
}
