import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/screenB': (context) => ScreenB(),
      },
      home: ScreenA(),
    );
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
    final data = await Navigator.pushNamed(
      context,
      '/screenB',
      arguments: 'Hi from A',
    );
    setState(() => result = data as String);
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
            Text('Result: $result'),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Screen B')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Message: $message'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Hi back from B'),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
