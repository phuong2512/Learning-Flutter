import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/imperative_and_named/screen_2.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 1")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Screen 1", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Screen2()),
              ),
              child: const Text("Push Screen 2"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Screen2()),
              ),
              child: const Text("Replace to Screen 2"),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/named_route_screen',
              ),
              child: const Text("Replace to Named Route"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Navigator (pop)"),
            ),
          ],
        ),
      ),
    );
  }
}
