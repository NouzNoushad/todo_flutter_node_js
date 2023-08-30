import 'package:flutter/material.dart';
import 'package:todo_flutter/data/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/todo_repository.dart';

class BlocWidget extends StatelessWidget {
  final Widget child;
  const BlocWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        create: (context) => TodoListBloc(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        )..add(const TodoLoadedEvent()),
        child: child,
      ),
    );
  }
}
