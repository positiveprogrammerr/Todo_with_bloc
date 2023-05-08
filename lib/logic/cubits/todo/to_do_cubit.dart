import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../user/user_cubit.dart';


part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final UserCubit userCubit;
  ToDoCubit({required this.userCubit})
      : super(ToDoInitial([
          Todo(id: UniqueKey().toString(), title: 'Go home', userId:'1',isDone: true),
          Todo(id: UniqueKey().toString(), title: 'Go lesson', userId: '1',isDone: false),
          Todo(id: UniqueKey().toString(), title: 'Do box', userId: '1',isDone: false),
        ]));

  void getTodos(){
    final user  = userCubit.currentUser;
    final todos = state.todos!.where((element) => element.userId==user.id).toList();
    emit(TodosLoaded(todos ));
  }

  void addToDo(String title) {
    final user  = userCubit.currentUser;
    try {
      final todo = Todo(id: UniqueKey().toString(), title: title,userId: user.id);
      final todos = [...state.todos!,todo];
      emit(ToDoAdded());
      emit(TodosLoaded(todos ));
    } catch (e) {
      emit(const ToDoError('Error occured!'));
    }
  }

  void editToDo(Todo todo) {
    try {
      final todos = state.todos!.map((e){
        if(e.id == todo.id){
          return todo;
        }else{
          return e;
        }
      }).toList();
     
      emit(ToDoEdited());
         emit(TodosLoaded(todos ));
    } catch (e) {
      emit(const ToDoError('Error occured!'));
    }
  }

  void toggleTodo(String id) {
    final todos = state.todos;
    final index = todos!.indexWhere((t) => t.id == id);
    todos[index].isDone = !todos[index].isDone;
    emit(ToDoToggled());
      emit(TodosLoaded(todos ));
  }

  void deleteTodo(String id){
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(ToDoDeleted());
      emit(TodosLoaded(todos ));
  }

  List<Todo> searchTodos(String title){
    return state.todos!.where((todo) => todo.title.toLowerCase().contains(title.toLowerCase())).toList();
  }
}
