import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email']);
}

class UserService {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 3));

    final List<Map<String, dynamic>> response = [
      {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
      {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'},
      {'id': 3, 'name': 'Charlie', 'email': 'charlie@example.com'},
    ];

    return response.map((json) => User.fromJson(json)).toList();
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserService _userService = UserService();
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _userService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(child: Text(user.name[0])),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SRP Users',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const UserListPage(),
    );
  }
}
