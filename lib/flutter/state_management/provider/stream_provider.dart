import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    StreamProvider<int>(
      create: (context) => Stream.periodic(
        Duration(seconds: 1),
        (second) => DateTime.now().second,
      ),
      initialData: 0,
      child: MaterialApp(home: StreamProviderDemoScreen()),
    ),
  );
}

class StreamProviderDemoScreen extends StatefulWidget {
  const StreamProviderDemoScreen({super.key});

  @override
  State<StreamProviderDemoScreen> createState() =>
      _StreamProviderDemoScreenState();
}

class _StreamProviderDemoScreenState extends State<StreamProviderDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider Demo')),
      body: Center(
        child: Consumer<int>(
          builder: (context, value, child) =>
              Text('Second: $value', style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
