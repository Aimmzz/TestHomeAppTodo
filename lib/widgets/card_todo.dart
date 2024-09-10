import 'package:flutter/material.dart';
import 'package:home_test_flutter/commons/color.dart';
import 'package:home_test_flutter/data/database.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo task;
  final void Function(bool?) onCheckboxChanged;
  final VoidCallback onDelete;

  const TodoCard({
    Key? key,
    required this.task,
    required this.onCheckboxChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Checkbox(
            value: task.type == 2,
            onChanged: onCheckboxChanged,
          ),
          title: Text(
            task.name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.black
            ),
          ),
          subtitle: Text(
            'Due date: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: ColorValues.darkGrey
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: ColorValues.oragePastel),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
