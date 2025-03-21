import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';
import 'package:todo_list/feature/app/controllers/splash_controller.dart';
import 'package:todo_list/feature/app/views/base_view.dart';

class SplashView extends BaseView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.isShow.value ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Text(
              'TL',
              style: TextStyle(
                color: AppColors.kprimaryColor,
                fontSize: AppDimension.largeFontSize * 5,
                fontWeight: FontWeight.w700,
                letterSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
