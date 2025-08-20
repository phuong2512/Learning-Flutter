import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'AvenueMadison', fontSize: 25),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Font Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Avenue de Madison font!',
              ),

              Text(
                'Hello with LemonMilk-Regular font!',
                style: TextStyle(fontFamily: 'LemonMilk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}