part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object?> get props => [];
}

class TodoLoadedEvent extends TodoListEvent {
  const TodoLoadedEvent();

  @override
  List<Object?> get props => [];
}

class TodoAddEvent extends TodoListEvent {
  final TodoAddRequest addRequest;
  const TodoAddEvent(this.addRequest);

  @override
  List<Object?> get props => [addRequest];
}

class TodoDeleteEvent extends TodoListEvent {
  final String id;
  const TodoDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
