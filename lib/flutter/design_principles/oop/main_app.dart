import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/design_principles/oop/counter_service.dart';
import 'package:learning_flutter/flutter/design_principles/oop/counter_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterService = SimpleCounterService();

    return MaterialApp(
      title: 'OOP Counter',
      home: CounterScreen(service: counterService),
    );
  }
}