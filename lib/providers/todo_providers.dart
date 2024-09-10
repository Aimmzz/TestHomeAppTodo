import 'package:flutter/material.dart';
import 'package:home_test_flutter/data/database.dart';

class TodoProvider with ChangeNotifier {
  late AppDb _database;
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  String _selectedFilter = 'Semua';
  String _searchQuery = '';

  List<Todo> get todos => _filteredTodos;
  String get selectedFilter => _selectedFilter;

  TodoProvider() {
    _database = AppDb();
    loadTodos();
  }

  Future<void> loadTodos([String filter = 'Semua']) async {
    _selectedFilter = filter;
    if (filter == 'Semua') {
      _todos = await _database.getAllTodo();
    } else if (filter == 'Belum Selesai') {
      _todos = await _database.getTodoByType(1);
    } else {
      _todos = await _database.getTodoByType(2);
    }
    _applySearchQuery();
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async {
    await _database.deleteTodo(id);
    loadTodos(_selectedFilter);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applySearchQuery();
    notifyListeners();
  }

  void _applySearchQuery() {
    if (_searchQuery.isEmpty) {
      _filteredTodos = _todos;
    } else {
      _filteredTodos = _todos.where((todo) =>
          todo.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
  }

  Future<void> updateTodoStatus(Todo task, bool isChecked) async {
    final updatedType = isChecked ? 2 : 1;
    await _database.updateTodo(task.id, updatedType);
    loadTodos(_selectedFilter);
  }
}
