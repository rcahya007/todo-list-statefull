import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';

// ignore: must_be_immutable
class ToDoItem extends StatelessWidget {
  ToDo todo;
  final Function todoChanged;
  final Function todoDeleted;
  final Function todoEdit;
  ToDoItem({
    super.key,
    required this.todo,
    required this.todoChanged,
    required this.todoDeleted,
    required this.todoEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            todoChanged(todo);
          },
          icon: Icon(
            todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.purple[900],
          ),
        ),
        title: Text(
          todo.taskTodo!,
          style: TextStyle(
            decoration:
                todo.isDone! ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                onPressed: () {
                  todoEdit(todo);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                onPressed: () {
                  todoDeleted(todo.id);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
