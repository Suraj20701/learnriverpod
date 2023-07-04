import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  String title, description;
  bool isCompleted = false;
  Todo(this.title, this.description, {this.isCompleted = false});

  Todo toogleCompleted() {
    isCompleted = !isCompleted;
    return this;
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (index != i) state[i]
    ];
  }

  void toogleIsCompleted(index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (index == i) state[i].toogleCompleted() else state[i],
    ];
  }
}
