import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/themes/app_theme.dart';
import 'package:todo_list/core/utils/shared_preferences_util.dart';

class ThemeController extends GetxController {
  final isDarkMode = false.obs;

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  Future<void> init() async {
    final isDarkModeStorage = await SharedPreferencesUtil.getThemeMode();

    if (isDarkModeStorage != null) {
      isDarkMode.value = isDarkModeStorage;
      Get.changeTheme(
        isDarkMode.value ? AppTheme.darkThemeData : AppTheme.lightThemeData,
      );
      return;
    }

    final Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    Get.changeTheme(
      isDarkMode.value ? AppTheme.darkThemeData : AppTheme.lightThemeData,
    );
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? AppTheme.darkThemeData : AppTheme.lightThemeData,
    );
    await SharedPreferencesUtil.saveThemeMode(isDarkMode.value);
  }
}
