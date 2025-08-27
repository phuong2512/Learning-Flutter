import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Counter {
  int _count = 0;

  Counter._internal();

  static final Counter _instance = Counter._internal();

  static Counter getInstance() => _instance;

  int get count => _count;

  void increment() {
    _count++;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Singleton Counter', home: CounterPage());
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final counter = Counter.getInstance();
  var c1 = Counter.getInstance();
  var c2 = Counter.getInstance();

  void _incrementCounter() {
    counter.increment();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Singleton Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.count}', style: TextStyle(fontSize: 32)),
            Text('Count: ${c1.count}', style: TextStyle(fontSize: 32)),
            Text('Count: ${c2.count}', style: TextStyle(fontSize: 32)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
