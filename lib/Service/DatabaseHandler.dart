import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/TodoModel.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'to_do.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY, "
              "title TEXT NOT NULL, "
              "description TEXT NOT NULL, "
              "status TEXT NOT NULL, "
              "startDate Text NOT NULL, "
              "modifiedDate TEXT, "
              "endDate TEXT NOT NULL,"
              "progress INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertTodo(TodoModel todo) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('todo', todo.toMap());
    return result;
  }

  Future<List<TodoModel>> retrieveTodoByStatus(String status) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('todo', where: "status = ?", whereArgs: [status]);
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<int> updateTodoStatus(TodoModel todo) async {
    final Database db = await initializeDB();
    var result = await db
        .update('todo', todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
    return result;
  }
}
