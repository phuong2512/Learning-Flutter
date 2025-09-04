import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/json/automated/model/address.dart';
import 'package:learning_flutter/flutter/api/json/automated/model/user.dart';
import 'package:learning_flutter/flutter/api/json/automated/model/user_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User JSON Parser',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late User parsedUser;
  late String jsonOutput;

  @override
  void initState() {
    super.initState();
    String jsonString = '''
      {
        "id": "123",
        "full_name": "Phuong",
        "address": {"street": "Pham Van Dong", "city": "HN"},
        "registered_at": 1698326400000,
        "status": 1
      }
    ''';
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    parsedUser = User.fromJson(userMap);

    User newUser = User(
      id: "159",
      name: "Phuong",
      age: 30,
      address: Address('159', 'HCM'),
      password: "secret",
      registeredAt: DateTime.now(),
      status: UserStatus.pending,
    );
    jsonOutput = jsonEncode(newUser.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User JSON Parser')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Parsed User from JSON:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('ID: ${parsedUser.id}'),
            Text('Name: ${parsedUser.name}'),
            Text('Age: ${parsedUser.age}'),
            Text('Address: ${parsedUser.address?.toString() ?? 'null'}'),
            Text('Registered At: ${parsedUser.registeredAt}'),
            Text('Status: ${parsedUser.status}'),
            const SizedBox(height: 24),
            const Text(
              'Serialized New User to JSON:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(jsonOutput),
          ],
        ),
      ),
    );
  }
}
