import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnflutter/providers/counter_provider.dart';
import './providers/todo_provider.dart';

void main(List<String> args) {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return CheckboxListTile(
            value: todo.isCompleted,
            onChanged: (value) =>
                ref.read(todoProvider.notifier).toogleIsCompleted(index),
            title: Text(todo.title),
            subtitle: Text(todo.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(todoProvider.notifier)
            .addTodo(Todo("Read", "Read the book")),
        child: const Text("+"),
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      body: Center(child: Text(counter.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.watch(counterProvider.notifier).increment(),
        child: const Text('+'),
      ),
    );
  }
}
