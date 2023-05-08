import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:block_cubit/data/models/todo.dart';
import 'package:block_cubit/logic/blocs/todo/todo_state.dart';
import 'package:block_cubit/logic/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, ToDoState> {
  final UserBloc userBloc;
  TodoBloc(this.userBloc)
      : super(ToDoInitial([
          Todo(
              id: UniqueKey().toString(),
              title: 'Go home',
              userId: '1',
              isDone: true),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go lesson',
              userId: '1',
              isDone: false),
          Todo(
              id: UniqueKey().toString(),
              title: 'Do box',
              userId: '1',
              isDone: false),
        ])) {
    on<LoadTodosEvent>(_getTodos);
    on<AddNewToDoEvent>(_addToDo);
    on<ToggleToDoEvent>(_toggleTodo);
    on<DeleteToDoEvent>(_deleteTodo);
  }

  void _getTodos(LoadTodosEvent event, Emitter<ToDoState> emit) {
    final user = userBloc.currentUser;
    final todos =
        state.todos!.where((element) => element.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void _addToDo(AddNewToDoEvent event, Emitter<ToDoState> emit) {
    final user = userBloc.currentUser;
    try {
      final todo =
          Todo(id: UniqueKey().toString(), title: event.title, userId: user.id);
      final todos = [...state.todos!, todo];
      emit(ToDoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(const ToDoError('Error occured!'));
    }
  }

  void _editToDo(EditToDoEvent event, Emitter<ToDoState> emit) {
    try {
      final todos = state.todos!.map((e) {
        if (e.id == event.id) {
          return event ;
        } else {
          return e;
        }
      }).toList();

      emit(ToDoEdited());
      emit(TodosLoaded(todos as List<Todo>));
    } catch (e) {
      emit(const ToDoError('Error occured!'));
    }
  }

  void _toggleTodo(ToggleToDoEvent event, Emitter<ToDoState> emit) {
    final todos = state.todos;
    final index = todos!.indexWhere((t) => t.id == event.id);
    todos[index].isDone = !todos[index].isDone;
    emit(ToDoToggled());
    emit(TodosLoaded(todos));
  }

  void _deleteTodo(DeleteToDoEvent event, Emitter<ToDoState> emit) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == event.id);
    emit(ToDoDeleted());
    emit(TodosLoaded(todos));
  }
  List<Todo> searchTodos(String title){
    return state.todos!.where((todo) => todo.title.toLowerCase().contains(title.toLowerCase())).toList();
  }
}
