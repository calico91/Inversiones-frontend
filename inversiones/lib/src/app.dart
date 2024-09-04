import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_binding.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/routes/route_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      getPages: RoutePages.all,
      initialRoute: RouteNames.splash,
      initialBinding: const AppBinding(),
    );
  }
}
