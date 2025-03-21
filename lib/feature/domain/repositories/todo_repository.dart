import 'package:todo_list/feature/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  /// Get all todo
  Future<List<TodoEntity>> getAllTodo();

  /// Search todo
  Future<List<TodoEntity>> searchTodo({String? keySearch, DateTime? dueDate});

  /// Insert todo
  Future<bool> insertTodo({required TodoEntity todo});

  /// Update todo
  Future<bool> updateTodo({required TodoEntity todo});

  /// Delete todo
  Future<bool> deleteTodo({required TodoEntity todo});
}
