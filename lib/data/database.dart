import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:home_test_flutter/model/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [Todos],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodo() async {
    return await select(todos).get();
  }

  Future<List<Todo>> getTodoByType(int type) async {
    return await (select(todos)..where((tbl) => tbl.type.equals(type))).get();
  }

  Future updateTodo(int id, int type) async {
    return (update(todos)..where((tbl) => tbl.id.equals(id)))
        .write(TodosCompanion(type: Value(type)));
  }

  Future deleteTodo(int id) async {
    return (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  }

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}