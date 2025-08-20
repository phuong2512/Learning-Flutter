import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScreenA());
  }
}

class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  String result = '';

  void _navigateToB() async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenB(message: 'Hello from A'),
      ),
    );
    setState(() {
      result = data ?? 'No result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen A')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _navigateToB, child: Text('Go to B')),
            Text('Result from B: $result'),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  final String message;

  const ScreenB({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen B')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Received: $message'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Hello back from B'),
              child: Text('Return Data to A'),
            ),
          ],
        ),
      ),
    );
  }
}
