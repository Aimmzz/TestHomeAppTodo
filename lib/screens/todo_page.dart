import 'package:flutter/material.dart';
import 'package:home_test_flutter/commons/color.dart';
import 'package:home_test_flutter/providers/todo_providers.dart';
import 'package:home_test_flutter/screens/add_todo_page.dart';
import 'package:home_test_flutter/widgets/card_todo.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'To - Do List',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorValues.purplePastel,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search to do...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (query) {
                Provider.of<TodoProvider>(context, listen: false)
                    .setSearchQuery(query);
              },
            ),
            const SizedBox(height: 16),
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return DropdownButton<String>(
                  value: todoProvider.selectedFilter,
                  icon: const Icon(Icons.filter_list),
                  isExpanded: true,
                  items: <String>['Semua', 'Belum Selesai', 'Selesai'].map((String value) {
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
                      child: Text(
                        'No To-Do available',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorValues.purple
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final task = todos[index];
                      return TodoCard(
                        task: task,
                        onCheckboxChanged: (bool? value) {
                          todoProvider.updateTodoStatus(task, value ?? false);
                        },
                        onDelete: () {
                          todoProvider.deleteTodo(task.id);
                        },
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
        backgroundColor: ColorValues.purple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTodoPage(),
          ).then((_) {
            Provider.of<TodoProvider>(context, listen: false).loadTodos(
              Provider.of<TodoProvider>(context, listen: false).selectedFilter
            );
          });
        },
        tooltip: 'Add Task',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
