import 'dart:developer';
import 'package:flutter/material.dart';

class Bird {
  String name;
  Bird(this.name);
}

abstract class Flyable {
  void fly();
}

class Sparrow extends Bird implements Flyable {
  Sparrow() : super("Sparrow");

  @override
  void fly() {
    log("Sparrow is flying");
  }
}

class Penguin extends Bird {
  Penguin() : super("Penguin");
}

class LSPDemoApp extends StatelessWidget {
  const LSPDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final birds = [Sparrow(), Penguin()];

    return Scaffold(
      appBar: AppBar(title: const Text('Birds ')),
      body: ListView.builder(
        itemCount: birds.length,
        itemBuilder: (context, index) {
          final bird = birds[index];
          return ListTile(
            title: Text(bird.name),
            subtitle: bird is Flyable
                ? const Text("This bird can fly.")
                : const Text("This bird cannot fly."),
            trailing: IconButton(
              icon: bird is Flyable
                  ? const Icon(Icons.done, color: Colors.green)
                  : const Icon(Icons.close, color: Colors.red),
              onPressed: bird is Flyable ? () => (bird as Flyable).fly() : null,
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSP Example',
      theme: ThemeData(useMaterial3: true),
      home: const LSPDemoApp(),
    );
  }
}
