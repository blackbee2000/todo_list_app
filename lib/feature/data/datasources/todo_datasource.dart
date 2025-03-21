import 'package:todo_list/core/database/client_database.dart';
import 'package:todo_list/core/database/client_manager_database.dart';
import 'package:todo_list/feature/data/models/todo_model.dart';
import 'package:todo_list/feature/domain/entities/todo_entity.dart';

class TodoDatasource {
  static TodoDatasource get to => TodoDatasource();

  /// Get all todo
  Future<List<TodoModel>> getAllTodo() async {
    try {
      final result = await ClientDatabaseManager.instance.query(
        ClientDatabase.tableTodos,
      );

      return result.map((e) => TodoModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Search todo
  Future<List<TodoModel>> searchTodo({
    String? keySearch,
    DateTime? dueDate,
  }) async {
    try {
      final result = keySearch == null && dueDate == null
          ? await ClientDatabaseManager.instance.query(
              ClientDatabase.tableTodos,
            )
          : await ClientDatabaseManager.instance.query(
              ClientDatabase.tableTodos,
              where: keySearch != null && dueDate != null
                  ? 'title LIKE ? AND due_date BETWEEN ? AND ?'
                  : keySearch != null && dueDate == null
                      ? 'title LIKE ?'
                      : 'due_date BETWEEN ? AND ?',
              whereArgs: keySearch != null && dueDate != null
                  ? [
                      '%$keySearch%',
                      "${dueDate.toIso8601String().substring(0, 10)}T00:00:00",
                      "${dueDate.toIso8601String().substring(0, 10)}T23:59:59"
                    ]
                  : keySearch != null && dueDate == null
                      ? ['%$keySearch%']
                      : [
                          "${dueDate?.toIso8601String().substring(0, 10)}T00:00:00",
                          "${dueDate?.toIso8601String().substring(0, 10)}T23:59:59"
                        ],
            );
      return result.map((e) => TodoModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Insert todo
  Future<bool> insertTodo({required TodoEntity todo}) async {
    try {
      final result = await ClientDatabaseManager.instance.insert(
        ClientDatabase.tableTodos,
        todo.toMapCreate(),
      );

      return result > 0 ? true : false;
    } catch (e) {
      rethrow;
    }
  }

  /// Update todo
  Future<bool> updateTodo({required TodoEntity todo}) async {
    try {
      final result = await ClientDatabaseManager.instance.update(
        ClientDatabase.tableTodos,
        todo.toMapUpdate(),
        where: ' id = ? ',
        whereArgs: [todo.id],
      );

      return result > 0 ? true : false;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete user
  Future<bool> deleteUser({required TodoEntity todo}) async {
    try {
      final result = await ClientDatabaseManager.instance.delete(
        ClientDatabase.tableTodos,
        where: ' id = ? ',
        whereArgs: [todo.id],
      );

      return result > 0 ? true : false;
    } catch (e) {
      rethrow;
    }
  }
}
