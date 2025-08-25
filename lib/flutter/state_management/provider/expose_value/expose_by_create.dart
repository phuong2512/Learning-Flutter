import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(home: CounterWrapper()));
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterWrapper extends StatefulWidget {
  const CounterWrapper({super.key});

  @override
  State<CounterWrapper> createState() => _CounterWrapperState();
}

class _CounterWrapperState extends State<CounterWrapper> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (_) => Counter(),
      builder: (context, widget) {
        final counter = Provider.of<Counter>(context);
        return Scaffold(
          appBar: AppBar(title: Text('Counter with create() inside State')),
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
