import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/imperative_and_named/named_route_screen.dart';
import 'package:learning_flutter/flutter/navigate/navigation/imperative_and_named/screen_1.dart';
void main(){
  runApp(MaterialApp(
    routes: {
      '/': (context) => ImperativeNavigatorScreen(),
      '/named_route_screen': (context) => NamedRouteScreen(),
    },
  ));
}
class ImperativeNavigatorScreen extends StatefulWidget {
  const ImperativeNavigatorScreen({super.key});

  @override
  State<ImperativeNavigatorScreen> createState() => _ImperativeNavigatorScreenState();
}

class _ImperativeNavigatorScreenState extends State<ImperativeNavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Navigation Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Screen1())),
              child: const Text("Navigator (push)"),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/named_route_screen'),
              child: const Text("Named Routes"),
            ),
          ],
        ),
      ),
    );
  }
}
