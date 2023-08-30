import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_flutter/data/model/todo_list.dart';
import 'package:todo_flutter/data/repositories/todo_repository.dart';

import '../../model/todo_add/todo_add_request.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoRepository todoRepository;
  TodoListBloc({required this.todoRepository}) : super(TodoListInitial()) {
    on<TodoLoadedEvent>(getTodoList);
    on<TodoAddEvent>(addTodo);
    on<TodoDeleteEvent>(deleteTodo);
  }

  FutureOr<void> getTodoList(
      TodoLoadedEvent event, Emitter<TodoListState> emit) async {
    emit(TodoLoadingState());
    try {
      List<TodoListResponse> todoList = await todoRepository.getTodoList();
      emit(TodoLoadedState(todoList));
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> addTodo(
      TodoAddEvent event, Emitter<TodoListState> emit) async {
    emit(TodoLoadingState());
    try {
      String message = await todoRepository.addTodo(event.addRequest);
      List<TodoListResponse> todoList = await todoRepository.getTodoList();
      emit(TodoAddedState(message));
      emit(TodoLoadedState(todoList));
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> deleteTodo(
      TodoDeleteEvent event, Emitter<TodoListState> emit) async {
    emit(TodoLoadingState());
    try {
      String message = await todoRepository.deleteTodo(event.id);
      List<TodoListResponse> todoList = await todoRepository.getTodoList();
      emit(TodoDeleteState(message));
      emit(TodoLoadedState(todoList));
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }
}
