part of 'active_todos_cubit_cubit.dart';

@immutable
abstract class ActiveTodosCubitState {}

class ActiveTodosCubitInitial extends ActiveTodosCubitState {}

class ActiveTodosLoaded extends ActiveTodosCubitState{
  final List<Todo> todos;
  ActiveTodosLoaded(this.todos);
}