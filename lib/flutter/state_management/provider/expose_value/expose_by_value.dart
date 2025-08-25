import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(home: CounterScreen()));
}

class Counter with ChangeNotifier {
  int _count = 5;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late final Counter _counter;

  @override
  void initState() {
    super.initState();
    _counter = Counter();
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _counter,
      builder: (context, widget) {
        final counter = Provider.of<Counter>(context);
        return Scaffold(
          appBar: AppBar(title: Text('Expose by value')),
          body: Center(
            child: Text(
              'Count: ${counter.count}',
              style: TextStyle(fontSize: 30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: counter.increment,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}