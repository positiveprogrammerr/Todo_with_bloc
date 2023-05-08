
import 'package:block_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:block_cubit/logic/blocs/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/todo.dart';

// ignore: must_be_immutable
class ManageToDo extends StatefulWidget {
  final Todo? todo;
  const ManageToDo({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  State<ManageToDo> createState() => _ManageToDoState();
}

class _ManageToDoState extends State<ManageToDo> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (widget.todo == null) {
      BlocProvider.of<TodoBloc>(context).add(AddNewToDoEvent(_title));
    } else {
      BlocProvider.of<TodoBloc>(context).add(EditToDoEvent(widget.todo!.id, _title));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, ToDoState>(
      listener: (context, state) {
        if (state is ToDoAdded || state is ToDoEdited) {
          Navigator.of(context).pop();
        } else if (state is ToDoError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.todo == null ? '' : widget.todo!.title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _title = newValue!;
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: _submit,
                    child: Text(widget.todo == null ? 'Add' : 'Edit')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
