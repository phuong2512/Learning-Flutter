import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ProxyProvider<CounterProvider, String>(
          update: (context, counterProvider, previous) =>
              'Count: ${counterProvider.count}',
        ),
      ],
      child: MaterialApp(home: ProxyProviderDemoScreen()),
    ),
  );
}

class ProxyProviderDemoScreen extends StatefulWidget {
  const ProxyProviderDemoScreen({super.key});

  @override
  State<ProxyProviderDemoScreen> createState() =>
      _ProxyProviderDemoScreenState();
}

class _ProxyProviderDemoScreenState extends State<ProxyProviderDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProxyProvider Demo')),
      body: Center(
        child: Consumer<String>(
          builder: (_, value, __) =>
              Text(value, style: const TextStyle(fontSize: 24)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterProvider>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
