// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/to_do_cubit.dart';

part 'completed_todos_state.dart';

class CompletedTodosCubit extends Cubit<CompletedTodosCubitState> {
  late final StreamSubscription todoCubitSubscription;
  final ToDoCubit todoCubit;
  CompletedTodosCubit(this.todoCubit) : super(CompletedTodosCubitInitial()){
    todoCubitSubscription = todoCubit.stream.listen((ToDoState state) {
      getCompletedTodos();
     });
  }

  void getCompletedTodos(){
      final todos = todoCubit.state.todos!.where((todo) => !todo.isDone).toList();
      emit(CompletedTodosLoaded(todos));
  }
  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
