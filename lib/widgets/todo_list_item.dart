
import 'package:block_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/todo.dart';
import '../logic/cubits/todo/to_do_cubit.dart';
import 'manage_todo.dart';

class ToDoListItem extends StatelessWidget {
  final Todo todo;
  const ToDoListItem({
    super.key,
    required this.todo,
  });
  void openManageToDO(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return ManageToDo(
          todo: todo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          onPressed: () => context.read<TodoBloc>().add(ToggleToDoEvent(todo.id)),
          icon: Icon(todo.isDone
              ? Icons.check_circle_outline_outlined
              : Icons.circle_outlined)),
      title: todo.isDone
          ? Text(
              todo.title,
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            )
          : Text(todo.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () =>context.read<TodoBloc>().add(DeleteToDoEvent(todo.id)), icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () => openManageToDO(context),
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
