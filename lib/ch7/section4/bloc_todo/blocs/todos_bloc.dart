import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/todos_state.dart';
import '../events/todos_event.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosState([])) {
    on<AddTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)..add(event.todo);
      emit(TodosState(newTodos));
    });

    on<DeleteTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)..remove(event.todo);
      emit(TodosState(newTodos));
    });

    on<ToggleCompletedTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });
  }

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print('$transition');
  }
}
