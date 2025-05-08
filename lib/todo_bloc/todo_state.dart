part of 'todo_bloc.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState { // kondisi saat data sudah terupdate
  final List<Todo> todos;
  DateTime? selectedDate;

  TodoLoaded({
    required this.todos,
    required this.selectedDate
  });
}
