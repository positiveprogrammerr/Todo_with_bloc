import 'package:block_cubit/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:block_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'package:block_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:block_cubit/logic/blocs/todo/todo_state.dart';

import '../../data/constants/tab_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/manage_todo.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/todo_list_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  var _init = false;
  @override
  void didChangeDependencies() {
    if (!_init) {
      // context.read<ToDoCubit>().getTodos();
      context.read<TodoBloc>().add(LoadTodosEvent());
      // context.read<ActiveTodosCubit>().getActiveTodos();
      context.read<ActiveTodosBloc>().add(LoadActiveTodosEvent());
      // context.read<CompletedTodosCubit>().getCompletedTodos();
      context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvent());
    }
    _init = true;

    super.didChangeDependencies();
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitles.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos Cubit'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                openSearchBar(context);
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  builder: (context) {
                    return const ManageToDo();
                  },
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: TabBar(
              tabs: TabTitles.tabs
                  .map((tab) => Tab(
                        text: tab,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          BlocListener<TodoBloc, ToDoState>(
            listener: (context, state) {
              if (state is TodosLoaded) {
                // Dispatch the LoadTodosEvent when TodosLoaded state is received
                context.read<ActiveTodosBloc>().add(LoadActiveTodosEvent());
                context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvent());
              }
            },
            child: BlocBuilder<TodoBloc, ToDoState>(
              builder: (context, state) {
                if (state is TodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No Todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) =>
                              ToDoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
          ),
          BlocBuilder<ActiveTodosBloc, ActiveTodosState>(
            builder: (context, state) {
              if (state is ActiveTodosLoaded) {
                return state.todos.isEmpty
                    ? const Center(
                        child: Text('No Todos'),
                      )
                    : ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) =>
                            ToDoListItem(todo: state.todos[index]),
                      );
              }
              return const Center(
                child: Text('No todos'),
              );
            },
          ),
          BlocBuilder<CompletedTodosBloc, CompletedTodosState>(
            builder: (context, state) {
              if (state is CompletedTodosLoaded) {
                return state.todos.isEmpty
                    ? const Center(
                        child: Text('No Todos'),
                      )
                    : ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) => ToDoListItem(
                          todo: state.todos[index],
                        ),
                      );
              }
              return const Center(
                child: Text('No todos'),
              );
            },
          ),
        ]),
      ),
    );
  }
}
