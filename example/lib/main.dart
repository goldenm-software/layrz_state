import 'package:flutter/material.dart';
import 'package:layrz_state/layrz_state.dart';

class MyStore extends LayrzStore {
  int counter = 0;
}

class IncrementMutation extends StateMutation<MyStore> {
  @override
  void perform() => store.counter++;
}

void main() {
  runApp(
    LayrzState(
      store: MyStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Layrz State Example')),
        body: Column(
          children: [
            Text("${LayrzState.of<MyStore>(context)}"),
            Center(
              child: StateBuilder<MyStore>(
                mutations: {IncrementMutation},
                builder: (context, store, status) {
                  return Text('Counter: ${store.counter}', style: const TextStyle(fontSize: 24));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => IncrementMutation(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
