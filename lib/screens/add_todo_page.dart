import 'package:flutter/material.dart';
import 'package:home_test_flutter/providers/add_todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTodoProvider(),
      child: Consumer<AddTodoProvider>(
        builder: (context, provider, child) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Add To-Do',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: provider.descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Task Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: provider.dueDateController,
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => provider.selectDueDate(context),
                      ),
                    ),
                    readOnly: true,
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton(
                      onPressed: () => provider.saveTodo(context),
                      child: const Text('Save To-Do'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
