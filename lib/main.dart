import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/config/translations.dart';
import 'core/di/di.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // keep it transparent
      statusBarIconBrightness: Brightness.dark, // Android icons dark
      statusBarBrightness: Brightness.light, // iOS status bar dark
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Borsa Now',
      translations: AppTranslation(),
     locale: Locale('ar',"SA"),

      fallbackLocale: Locale('ar',"SA"),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}

