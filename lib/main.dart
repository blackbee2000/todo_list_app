import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_list/core/database/client_manager_database.dart';
import 'package:todo_list/core/services/notification_local_service.dart';
import 'package:todo_list/core/themes/app_colors.dart';
import 'package:todo_list/feature/app/app/app.dart';

void config() {
  EasyLoading.instance.dismissOnTap = false;
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
  EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  EasyLoading.instance.backgroundColor = Colors.white;
  EasyLoading.instance.indicatorColor = AppColors.kprimaryColor;
  EasyLoading.instance.textColor = AppColors.kprimaryColor;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializedLocalNotifications();
  config();
  await ClientDatabaseManager.instance.open();
  runApp(const MyApp());
}
