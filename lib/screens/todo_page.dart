import 'package:flutter/material.dart';
import 'package:home_test_flutter/providers/todo_providers.dart';
import 'package:home_test_flutter/screens/add_todo_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search tasks...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return DropdownButton<String>(
                  value: todoProvider.selectedFilter,
                  icon: const Icon(Icons.filter_list),
                  isExpanded: true,
                  items: <String>['Semua', 'Belum', 'Selesai'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      todoProvider.loadTodos(newValue);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, child) {
                  final todos = todoProvider.todos;

                  if (todos.isEmpty) {
                    return const Center(
                      child: Text('No tasks available'),
                    );
                  }

                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final task = todos[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Checkbox(
                            value: task.type == 2,
                            onChanged: (bool? value) {
                              todoProvider.updateTodoStatus(task, value ?? false);
                            },
                          ),
                          title: Text(task.name),
                          subtitle: Text(
                              'Due date: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTodoPage(),
          ).then((_) {
            // Muat ulang data to-do setelah dialog ditutup
            Provider.of<TodoProvider>(context, listen: false).loadTodos(
              Provider.of<TodoProvider>(context, listen: false).selectedFilter
            );
          });
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
