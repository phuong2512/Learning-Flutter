import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(home: ChangeNotifierProviderDemoScreen()),
    ),
  );
}

class CounterProvider with ChangeNotifier {
  int _counter = 0;
  String str = "Hello";
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void changeStr() {
    str = str == "Hello" ? "Goodbye" : "Hello";
    notifyListeners();
  }
}

class ChangeNotifierProviderDemoScreen extends StatelessWidget {
  const ChangeNotifierProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select<CounterProvider, int>(
      (provider) => provider._counter,
    );
    final String str = context.watch<CounterProvider>().str;
    return Scaffold(
      appBar: AppBar(title: Text('ChangeNotifierProvider Demo')),
      body: Center(
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Value: $count')
                , Text('String: $str'),
              ],
            ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().increment();
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().changeStr();
              log(context.read<CounterProvider>().str);
            },
            child: const Icon(Icons.restart_alt),
          ),
        ],
      ),
    );
  }
}
