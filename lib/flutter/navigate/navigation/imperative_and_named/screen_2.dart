import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/imperative_and_named/screen_1.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Screen 2", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Screen1()),
                (route) => false,
              ),
              child: const Text("pushAndRemoveUntil Imperative Navigator Screen"),
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
