import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class AppState with ChangeNotifier {
  String messageFromA = '';
  String resultFromB = '';

  void updateMessage(String msg) {
    messageFromA = msg;
    notifyListeners();
  }

  void returnResult(String result) {
    resultFromB = result;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: ScreenA()),
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Screen A')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                appState.updateMessage('This is a message from A');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScreenB()),
                );
              },
              child: Text('Go to B'),
            ),
            Text('Result from B: ${appState.resultFromB}'),
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
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Screen B')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Received: ${appState.messageFromA}'),
            ElevatedButton(
              onPressed: () {
                appState.returnResult('This is a message from B');
                Navigator.pop(context);
              },
              child: Text('Return Result'),
            ),
          ],
        ),
      ),
    );
  }
}
