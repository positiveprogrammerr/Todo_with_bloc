import 'dart:async';
import 'package:bloc/bloc.dart';
import '../active_todos_cubit/active_todos_cubit_cubit.dart';
import '../todo/to_do_cubit.dart';



class ActiveTodosCubit extends Cubit<ActiveTodosCubitState> {
  late final StreamSubscription todoCubitSubscription;
  final ToDoCubit todoCubit;
  ActiveTodosCubit(this.todoCubit) : super(ActiveTodosCubitInitial()){
    todoCubitSubscription = todoCubit.stream.listen((ToDoState state) {
      getActiveTodos();
     });
  }

  void getActiveTodos(){
      final todos = todoCubit.state.todos!.where((todo) => !todo.isDone).toList();
      emit(ActiveTodosLoaded(todos));
  }
  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
