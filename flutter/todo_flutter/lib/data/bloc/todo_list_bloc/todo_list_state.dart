part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState extends Equatable {
  const TodoListState();
  @override
  List<Object?> get props => [];
}

final class TodoListInitial extends TodoListState {}

final class TodoLoadingState extends TodoListState {}

class TodoLoadedState extends TodoListState {
  final List<TodoListResponse> todoList;
  const TodoLoadedState(this.todoList);
  @override
  List<Object?> get props => [todoList];
}

class TodoAddedState extends TodoListState {
  final String message;
  const TodoAddedState(this.message);
  @override
  List<Object?> get props => [message];
}

class TodoDeleteState extends TodoListState {
  final String message;
  const TodoDeleteState(this.message);
  @override
  List<Object?> get props => [message];
}

class TodoErrorState extends TodoListState {
  final String error;
  const TodoErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
