import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  FutureProvider<String>(
    create: (context) =>
        Future.delayed(const Duration(seconds: 5), () => 'Data loaded'),
    initialData: 'Loading...',
    child: MaterialApp(home: const FutureProviderDemoScreen()),
  ),
);

class FutureProviderDemoScreen extends StatelessWidget {
  const FutureProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider Demo')),
      body: Center(
        child: Consumer<String>(
          builder: (context, value, child) =>
              Text(value, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
