import 'package:drift/drift.dart';

@DataClassName('Todo')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 128)();
  IntColumn get type  => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
}