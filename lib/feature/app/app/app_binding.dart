import 'package:get/get.dart';
import 'package:todo_list/feature/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/feature/domain/repositories/todo_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRepository>(
      () => TodoRepositoryImpl(),
      fenix: true,
    );
  }
}
