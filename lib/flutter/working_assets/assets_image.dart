import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Asset Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cat_1.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Image(
                image: AssetImage('assets/images/cat_2.png'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
