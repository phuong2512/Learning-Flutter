import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/design_principles/oop/counter_service.dart';

class CounterScreen extends StatefulWidget {
  final CounterService service;

  const CounterScreen({super.key, required this.service});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  void _increment() {
    widget.service.increment();
    setState(() {});
  }

  void _reset() {
    widget.service.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final counter = widget.service.counter;

    return Scaffold(
      appBar: AppBar(title: const Text('OOP Counter')),
      body: Center(child: CounterDisplay(value: counter.value)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _reset,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final int value;

  const CounterDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Count: $value',
      style: const TextStyle(fontSize: 32),
    );
  }
}