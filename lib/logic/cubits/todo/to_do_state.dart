// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'to_do_cubit.dart';

@immutable
 class ToDoState {
  final List<Todo>? todos; 
  const ToDoState({this.todos,
 });
}

class ToDoInitial extends ToDoState {
   final List<Todo> todos; 
   const ToDoInitial(this.todos);
}

class TodosLoaded extends ToDoState{
  final List<Todo> todos; 
   const TodosLoaded(this.todos):super(todos: todos);
}
class ToDoAdded extends ToDoState{
}
class ToDoEdited extends ToDoState{
}
class ToDoToggled extends ToDoState{
}
class ToDoDeleted extends ToDoState{
}

class ToDoError extends ToDoState{
  final String message;
  const ToDoError(this.message);
}