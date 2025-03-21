class ClientDatabase {
  ClientDatabase._();
  static const String databaseName = 'todo_list.db';
  static const int currentVersion = 1;

  static const String tableTodos = 'Todos';

  /// SQL
  static const String initSql = 'assets/sql/todo.sql';
}
