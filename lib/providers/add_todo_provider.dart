import 'package:flutter/material.dart';
import 'package:home_test_flutter/data/database.dart';
import 'package:intl/intl.dart';

class AddTodoProvider with ChangeNotifier {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  DateTime? _selectedDate;
  final AppDb database = AppDb();

  DateTime? get selectedDate => _selectedDate;

  // Method to select a due date
  Future<void> selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      notifyListeners();
    }
  }

  // Method to save a new to-do item to the database
  Future<void> saveTodo(BuildContext context) async {
    final String description = descriptionController.text;
    final DateTime? dueDate = _selectedDate;

    if (description.isEmpty || dueDate == null) {
      // Show error message if fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    // Insert to-do into the database
    await database.into(database.todos).insert(
      TodosCompanion.insert(
        name: description,
        type: 1, // Default type (not completed)
        createdAt: DateTime.now(),
        dueDate: dueDate,
      ),
    );

    // Close the dialog after saving
    Navigator.of(context).pop();
  }

  // Dispose controllers when not needed
  void disposeControllers() {
    descriptionController.dispose();
    dueDateController.dispose();
  }
}
