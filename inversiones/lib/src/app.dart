import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/app_binding.dart';
import 'package:inversiones/src/ui/pages/routes/route_names.dart';
import 'package:inversiones/src/ui/pages/routes/route_pages.dart';
import 'package:inversiones/src/ui/pages/utils/colores_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: GetMaterialApp(
        theme: ThemeData(
          primaryColor: ColoresApp.azulPrimario,
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: ColoresApp.azulPrimario,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        getPages: RoutePages.all,
        initialRoute: RouteNames.splash,
        initialBinding: const AppBinding(),
      ),
    );
  }
}
