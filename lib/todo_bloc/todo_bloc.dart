import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_133/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoaded(todos: [], selectedDate: null)) {
    on<TodoEventAdd>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updateTodos = List.from(currentState.todos);
        updateTodos.add(
          Todo(
            title: event.title, 
            date: event.date, 
            isComplete: false
          )
        );
        emit(
          TodoLoaded(
            todos: updateTodos, 
            selectedDate: currentState.selectedDate,
          )
        ); 
      }
    });

    on<TodoSelectDate>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        emit(TodoLoaded(
          todos: currentState.todos, 
          selectedDate: event.date
        ));
      }
    });

    on<TodoEventComplete>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updateTodos = List.from(currentState.todos);
        if (event.index >= 0 && event.index < updateTodos.length) {
          updateTodos[event.index] = Todo(
            title: updateTodos[event.index].title, 
            date: updateTodos[event.index].date, 
            // iscompleted: !updatedTodos[event.index].isCompleted,
            isComplete: updateTodos[event.index].isComplete == true,
          );
          emit (
            TodoLoaded(
              todos: updateTodos, 
              selectedDate: currentState.selectedDate
            )
          );
        }
      }
    });
  }
}
