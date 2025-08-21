import 'package:flutter/material.dart';

void main() {
  runApp(const ListenableBuilderScreen());
}

class CounterProvider with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count += 1;
    notifyListeners();
  }
}

class ListenableBuilderScreen extends StatefulWidget {
  const ListenableBuilderScreen({super.key});

  @override
  State<ListenableBuilderScreen> createState() => _ListenableBuilderScreenState();
}

class _ListenableBuilderScreenState extends State<ListenableBuilderScreen> {
  final CounterProvider _counter = CounterProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListenableBuilder Demo')),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Current counter value:'),
              ListenableBuilder(
                listenable: _counter,
                builder: (context,child) {
                  return Text('${_counter.count}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}