import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;

  const ProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Screen')),
      body: Center(
        child: Text('Name: $name', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}