import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/generated_routes/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final dynamic arguments = settings.arguments;
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomeScreen());

          case '/profile':
            final String name = arguments is String ? arguments : 'Unknown';
            return MaterialPageRoute(builder: (_) => ProfileScreen(name: name));

          default:
            return MaterialPageRoute(
              builder: (_) =>
                  Scaffold(body: Center(child: Text('404 - Not found'))),
            );
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile', arguments: 'Phương');
          },
          child: Text('Go to Profile Screen'),
        ),
      ),
    );
  }
}
