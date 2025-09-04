import 'dart:convert';

import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: JsonDemoScreen());
  }
}

class JsonDemoScreen extends StatefulWidget {
  const JsonDemoScreen({super.key});

  @override
  State<JsonDemoScreen> createState() => _JsonDemoScreenState();
}

class _JsonDemoScreenState extends State<JsonDemoScreen> {
  late User user;
  String encodedJson = "";
  String encodedJson2 = "";

  @override
  void initState() {
    super.initState();

    const String jsonString = '''
      {"name": "Phuong", "email": "phuong2@gmail.com"}
    ''';

    // 1. Deserialize
    final userMap = jsonDecode(jsonString);
    user = User.fromJson(userMap);

    // 2. Serialize
    encodedJson = jsonEncode(user);

    final user2 = User("Tran Van Phuong", "tvphuong@gmail.com");
    encodedJson2 = jsonEncode(user2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JSON Serialization Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "JSON Serialization:",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(
              "Hello, ${user.name}!",
            ),
            Text("Email: ${user.email}"),

            const SizedBox(height: 20),
            const Text(
              "JSON Deserialization:",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(encodedJson),

            const SizedBox(height: 20),
            const Text(
              "JSON user2:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(encodedJson2),
          ],
        ),
      ),
    );
  }
}
