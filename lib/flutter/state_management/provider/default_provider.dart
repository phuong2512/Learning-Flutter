import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => 'Hello World',
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Provider Demo')),
          body: Center(
            child: Consumer<String>(
              builder: (context, value, child) => Text(value, style: const TextStyle(fontSize: 24)),
            ),
          ),
        ),
      ),
    );
  }
}