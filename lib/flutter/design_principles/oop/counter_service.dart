import 'package:learning_flutter/flutter/design_principles/oop/counter_model.dart';
abstract class CounterService {
  Counter get counter;
  void increment();
  void reset();
}

class SimpleCounterService implements CounterService {
  final Counter _counter = Counter();

  @override
  Counter get counter => _counter;

  @override
  void increment() {
    _counter.increment();
  }

  @override
  void reset() {
    _counter.reset();
  }
}
