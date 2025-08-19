import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Theme(
        data: ThemeData(primarySwatch: Colors.blue),
        child: const HomeScreen(),
      ),
    ),
  );
}
