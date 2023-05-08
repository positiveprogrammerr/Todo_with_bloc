import 'package:block_cubit/logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'package:block_cubit/logic/blocs/todo/todo_bloc.dart';
import 'package:block_cubit/logic/blocs/user/user_bloc.dart';
import 'logic/blocs/active_todos/active_todos_bloc.dart';
import 'presentation/screens/todo_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (ctx) => UserCubit(),
        // ),
        // BlocProvider(
        //   create: (ctx) => ToDoCubit(userCubit: ctx.read<UserCubit>()),
        // ),
        // BlocProvider(
        //   create: (ctx) => ActiveTodosCubit( ctx.read<ToDoCubit>()),
        // ),
        //  BlocProvider(
        //   create: (ctx) => CompletedTodosCubit( ctx.read<ToDoCubit>()),
        // ),
        BlocProvider(
          create: (ctx) => UserBloc(),
        ),
        BlocProvider(
          create: (ctx) => TodoBloc( ctx.read<UserBloc>()),
        ),
        BlocProvider(
          create: (ctx) => ActiveTodosBloc( ctx.read<TodoBloc>()),
        ),
         BlocProvider(
          create: (ctx) => CompletedTodosBloc( ctx.read<TodoBloc>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const TodosScreen(),
          '/todo-details': (context) => const TodoDetailsScreen(),
        },
      ),
    );
  }
}
