import 'package:flutter/material.dart';

abstract class Shape {
  String getName();
  Color getColor();
  IconData getIcon();
}

class CircleShape implements Shape {
  @override
  String getName() => 'Circle';

  @override
  Color getColor() => Colors.red;

  @override
  IconData getIcon() => Icons.circle;
}

class SquareShape implements Shape {
  @override
  String getName() => 'Square';

  @override
  Color getColor() => Colors.blue;

  @override
  IconData getIcon() => Icons.square;
}

class TriangleShape implements Shape {
  @override
  String getName() => 'Triangle';

  @override
  Color getColor() => Colors.green;

  @override
  IconData getIcon() => Icons.change_history;
}

// class StarShape implements Shape {
//   @override
//   String getName() => 'Star';
//
//   @override
//   Color getColor() => Colors.yellow;
//
//   @override
//   IconData getIcon() => Icons.star;
// }
class ShapeListPage extends StatelessWidget {
  const ShapeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Shape> shapes = [
      CircleShape(),
      SquareShape(),
      TriangleShape(),
      // StarShape(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('OCP - Shape List')),
      body: ListView.builder(
        itemCount: shapes.length,
        itemBuilder: (context, index) {
          final shape = shapes[index];
          return ListTile(
            leading: Icon(shape.getIcon(), color: shape.getColor()),
            title: Text(shape.getName()),
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
      title: 'OCP Example',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const ShapeListPage(),
    );
  }
}
