import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_flutter/data/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_flutter/data/repositories/todo_repository.dart';
import 'package:todo_flutter/presentation/add_update_bottom_sheet.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    TodoRepository().getTodoList();
    return Scaffold(
        backgroundColor: ColorPicker.backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addOrUpdateTodo(context: context, todoType: TodoType.add);
          },
          backgroundColor: ColorPicker.primaryColor,
          child: const Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                'Todo',
              ),
              centerTitle: true,
              pinned: true,
              backgroundColor: ColorPicker.appBarColor,
            ),
            SliverFillRemaining(
              child: BlocConsumer<TodoListBloc, TodoListState>(
                listener: (context, state) {
                  if (state is TodoErrorState) {
                    Fluttertoast.showToast(msg: 'Unable to connect');
                  }
                  if (state is TodoAddedState) {
                    Fluttertoast.showToast(msg: 'Success');
                  }
                  if (state is TodoDeleteState) {
                    Fluttertoast.showToast(msg: 'Todo deleted successfully');
                  }
                },
                builder: (context, state) {
                  if (state is TodoLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorPicker.appBarColor,
                      ),
                    );
                  }
                  if (state is TodoLoadedState) {
                    return ListView.separated(
                        itemCount: state.todoList.length,
                        itemBuilder: (context, index) {
                          var todo = state.todoList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      todo.content,
                                      style: const TextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  addOrUpdateTodo(
                                      context: context,
                                      todo: todo,
                                      todoType: TodoType.update);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<TodoListBloc>().add(
                                      TodoDeleteEvent(todo.todoListResponseId));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 4,
                            ));
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }
}
