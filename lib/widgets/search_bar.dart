import 'package:block_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubits/todo/to_do_cubit.dart';

class SearchBar extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(onPressed: (){
      query = '';
    }, icon: const Icon(Icons.cancel_rounded)),

   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){close(context, null);}, icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<ToDoCubit>().searchTodos(query);
   return todos.isEmpty?const Center(child: Text('Can\'t find todos.'),): ListView.builder(
    itemCount: todos.length,
    itemBuilder: (context, index) => ListTile(
      onTap: (){
        Navigator.of(context).pushNamed('/todo-details',arguments: todos[index]);
      },
      title: Text(todos[index].title),),
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  if(query.isNotEmpty){
    final todos = context.read<TodoBloc>().searchTodos(query);
   return todos.isEmpty?const Center(child: Text('Can\'t find todos.'),): ListView.builder(
    itemCount: todos.length,
    itemBuilder: (context, index) => ListTile(
       onTap: (){
        Navigator.of(context).pushNamed('/todo-details',arguments: todos[index]);
      },
      title: Text(todos[index].title),),
   );
  }
  return Container();
  }
}