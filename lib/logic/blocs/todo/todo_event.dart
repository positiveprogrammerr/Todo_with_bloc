part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent{}
class AddNewToDoEvent extends TodoEvent{
  final String title;
  AddNewToDoEvent(this.title);
}
class EditToDoEvent extends TodoEvent{
  final String id;
  final String title;
  EditToDoEvent(this.id,this.title);
}
class ToggleToDoEvent extends TodoEvent{
  final String id;
  ToggleToDoEvent(this.id);
}
class DeleteToDoEvent extends TodoEvent{
  final String id;
  DeleteToDoEvent(this.id);
}