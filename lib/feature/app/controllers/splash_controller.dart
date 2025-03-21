import 'package:get/get.dart';
import 'package:todo_list/core/routes/app_routes.dart';
import 'package:todo_list/feature/app/controllers/base_controller.dart';

class SplashController extends BaseController {
  final isShow = false.obs;

  @override
  void onInit() {
    // Show logo
    Future.delayed(const Duration(seconds: 1)).then((_) {
      isShow.value = true;
    });
    // Go to todo list view
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Get.offAllNamed(AppRoutes.todoListScreen);
    });
    super.onInit();
  }
}
