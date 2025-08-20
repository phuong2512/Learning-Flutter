import 'package:flutter/material.dart';

class NamedRouteScreen extends StatelessWidget {
  const NamedRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Named Route Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Named Route Screen", style: TextStyle(fontSize: 25),),
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
