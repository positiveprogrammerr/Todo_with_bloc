part of 'completed_todos_cubit.dart';

@immutable
abstract class CompletedTodosCubitState {}

class CompletedTodosCubitInitial extends CompletedTodosCubitState {}

class CompletedTodosLoaded extends CompletedTodosCubitState{
  final List<Todo> todos;
  CompletedTodosLoaded(this.todos);
}