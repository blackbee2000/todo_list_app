import 'package:todo_list/feature/data/datasources/todo_datasource.dart';
import 'package:todo_list/feature/domain/entities/todo_entity.dart';
import 'package:todo_list/feature/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<bool> deleteTodo({required TodoEntity todo}) async {
    try {
      final result = await TodoDatasource.to.deleteUser(todo: todo);

      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TodoEntity>> getAllTodo() async {
    try {
      final result = await TodoDatasource.to.getAllTodo();

      return result.map((e) => e.transfer()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> insertTodo({required TodoEntity todo}) async {
    try {
      final result = await TodoDatasource.to.insertTodo(todo: todo);

      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateTodo({required TodoEntity todo}) async {
    try {
      final result = await TodoDatasource.to.updateTodo(todo: todo);

      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TodoEntity>> searchTodo({
    String? keySearch,
    DateTime? dueDate,
  }) async {
    try {
      final result = await TodoDatasource.to.searchTodo(
        keySearch: keySearch,
        dueDate: dueDate,
      );

      return result.map((e) => e.transfer()).toList();
    } catch (e) {
      return [];
    }
  }
}
