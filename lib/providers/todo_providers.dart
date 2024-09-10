import 'package:flutter/material.dart';
import 'package:home_test_flutter/data/database.dart';

class TodoProvider with ChangeNotifier {
  late AppDb _database;
  List<Todo> _todos = [];
  String _selectedFilter = 'Semua'; // Default filter

  List<Todo> get todos => _todos;
  String get selectedFilter => _selectedFilter;

  TodoProvider() {
    _database = AppDb();
    loadTodos();
  }

  Future<void> loadTodos([String filter = 'Semua']) async {
    _selectedFilter = filter;
    if (filter == 'Semua') {
      _todos = await _database.getAllTodo();
    } else if (filter == 'Belum') {
      _todos = await _database.getTodoByType(1);
    } else {
      _todos = await _database.getTodoByType(2);
    }
    notifyListeners();
  }

  Future<void> updateTodoStatus(Todo task, bool isChecked) async {
    final updatedType = isChecked ? 2 : 1;
    await _database.updateTodo(task.id, updatedType);
    loadTodos(_selectedFilter); // Reload todos with the current filter
  }
}
