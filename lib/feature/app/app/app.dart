import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/database/client_manager_database.dart';
import 'package:todo_list/core/routes/app_pages.dart';
import 'package:todo_list/core/routes/app_routes.dart';
import 'package:todo_list/core/themes/app_theme.dart';
import 'package:todo_list/core/themes/theme_controller.dart';
import 'package:todo_list/feature/app/app/app_binding.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeController = Get.put(ThemeController(), permanent: true);
  @override
  void dispose() {
    unawaited(ClientDatabaseManager.instance.closeConnection());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splashScreen,
      initialBinding: AppBinding(),
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('vi', 'VN'),
      builder: EasyLoading.init(),
    );
  }
}
