import 'package:flutter/material.dart';

abstract class User {
  String welcomeMessage();
}

class AdminUser implements User {
  @override
  String welcomeMessage() => 'Welcome, Admin!';
}

class GuestUser implements User {
  @override
  String welcomeMessage() => 'Welcome, Guest!';
}

class MemberUser implements User {
  @override
  String welcomeMessage() => 'Welcome, Member!';
}

class UserFactory {
  static User createUser(String role) {
    switch (role) {
      case 'admin':
        return AdminUser();
      case 'guest':
        return GuestUser();
      case 'member':
        return MemberUser();
      default:
        throw Exception('Invalid user role');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Factory Pattern Demo', home: UserPage());
  }
}

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String selectedRole = 'guest';
  String message = '';

  void _createUser() {
    User user = UserFactory.createUser(selectedRole);
    setState(() {
      message = user.welcomeMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Factory Method Pattern')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: selectedRole,
                items: ['admin', 'guest', 'member']
                    .map(
                      (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: _createUser, child: Text('Create User')),
              SizedBox(height: 15),
              Text(message, style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
