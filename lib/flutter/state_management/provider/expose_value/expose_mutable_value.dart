
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreetingService {
  final String username;

  GreetingService(this.username);

  String greet() => 'Hello, $username!';
}

class UserSettings with ChangeNotifier {
  String _username = 'Alice';
  String get username => _username;

  void updateUsername(String name) {
    _username = name;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSettings()),

        Provider(
          create: (context) {
            final username = context.read<UserSettings>().username;
            return GreetingService(username);
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final greetingService = context.watch<GreetingService>();
    final userSettings = context.read<UserSettings>();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ProxyProvider Demo')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(greetingService.greet()), // Hello, Alice/Bob...
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userSettings.updateUsername("Bob");
              },
              child: Text('Đổi tên thành Bob'),
            ),
          ],
        ),
      ),
    );
  }
}
