import 'package:get/get.dart';
import 'package:todo_list/core/routes/app_routes.dart';
import 'package:todo_list/feature/app/controllers/splash_controller.dart';
import 'package:todo_list/feature/app/controllers/todo_create_update_controller.dart';
import 'package:todo_list/feature/app/controllers/todo_list_controller.dart';
import 'package:todo_list/feature/app/views/splash/splash_view.dart';
import 'package:todo_list/feature/app/views/todo_create_update/todo_create_update_view.dart';
import 'package:todo_list/feature/app/views/todo_list/todo_list_view.dart';

class AppPages {
  AppPages._();

  static const Transition _kTransition = Transition.rightToLeftWithFade;
  static const Duration _kTransitionDuration = Duration(milliseconds: 200);

  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.todoListScreen,
      page: () => const TodoListView(),
      binding: BindingsBuilder.put(() => TodoListController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.createUpdateTodoScreen,
      page: () => const TodoCreateUpdateView(),
      binding: BindingsBuilder.put(() => TodoCreateUpdateController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
  ];
}
