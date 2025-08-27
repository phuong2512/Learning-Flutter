import 'package:flutter/material.dart';
import 'dart:math';

abstract class AreaCalculable {
  double calculateArea();
}

abstract class ShapeNameProvider {
  String getShapeName();
}

abstract class ShapeFactory {
  AreaCalculable createAreaCalculator(double value);
  ShapeNameProvider createNameProvider(double value);
}

class Circle implements AreaCalculable {
  final double radius;
  Circle(this.radius);

  @override
  double calculateArea() => pi * radius * radius;
}

class CircleNameProvider implements ShapeNameProvider {
  @override
  String getShapeName() => 'Circle';
}

class CircleFactory implements ShapeFactory {
  @override
  AreaCalculable createAreaCalculator(double value) => Circle(value);

  @override
  ShapeNameProvider createNameProvider(double value) => CircleNameProvider();
}

class Square implements AreaCalculable {
  final double side;
  Square(this.side);

  @override
  double calculateArea() => side * side;
}

class SquareNameProvider implements ShapeNameProvider {
  @override
  String getShapeName() => 'Square';
}

class SquareFactory implements ShapeFactory {
  @override
  AreaCalculable createAreaCalculator(double value) => Square(value);

  @override
  ShapeNameProvider createNameProvider(double value) => SquareNameProvider();
}

class Triangle implements AreaCalculable {
  final double base;
  final double height;
  Triangle(this.base, this.height);

  @override
  double calculateArea() => 0.5 * base * height;
}

class TriangleNameProvider implements ShapeNameProvider {
  @override
  String getShapeName() => 'Triangle';
}

class TriangleFactory implements ShapeFactory {
  @override
  AreaCalculable createAreaCalculator(double value) {
    return Triangle(10, value);
  }

  @override
  ShapeNameProvider createNameProvider(double value) => TriangleNameProvider();
}

class ShapeScreen extends StatefulWidget {
  final Map<String, ShapeFactory> factories;

  const ShapeScreen({required this.factories, super.key});

  @override
  State<ShapeScreen> createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  final TextEditingController inputController = TextEditingController();
  String result = '';
  String shapeType = 'Circle';
  String inputLabel = 'Enter Radius';

  @override
  void initState() {
    super.initState();
    _updateInputLabel();
  }

  void _updateInputLabel() {
    setState(() {
      if (shapeType == 'Circle') {
        inputLabel = 'Enter Radius';
      } else if (shapeType == 'Square') {
        inputLabel = 'Enter Side Length';
      } else if (shapeType == 'Triangle') {
        inputLabel = 'Enter Height (Base=10)';
      }
    });
  }

  void calculate() {
    final input = double.tryParse(inputController.text);
    if (input == null || input <= 0) {
      setState(() => result = 'Invalid input!');
      return;
    }

    final factory = widget.factories[shapeType];
    if (factory == null) {
      setState(() => result = 'Shape not supported!');
      return;
    }

    try {
      final calculator = factory.createAreaCalculator(input);
      final nameProvider = factory.createNameProvider(input);
      final area = calculator.calculateArea();
      final shapeName = nameProvider.getShapeName();

      setState(() {
        result = '$shapeName Area: ${area.toStringAsFixed(2)}';
      });
    } catch (e) {
      setState(() => result = 'Calculation error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SOLID Shape Area')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: shapeType,
              items: widget.factories.keys.map((String key) {
                return DropdownMenuItem<String>(value: key, child: Text(key));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => shapeType = value);
                  _updateInputLabel();
                }
              },
            ),
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: inputLabel),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: const Text('Calculate Area'),
            ),
            const SizedBox(height: 30),
            Text(
              result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  final factories = <String, ShapeFactory>{
    'Circle': CircleFactory(),
    'Square': SquareFactory(),
    'Triangle': TriangleFactory(),
  };

  runApp(SolidDemoApp(factories: factories));
}

class SolidDemoApp extends StatelessWidget {
  final Map<String, ShapeFactory> factories;

  const SolidDemoApp({required this.factories, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLID Shapes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ShapeScreen(factories: factories),
      debugShowCheckedModeBanner: false,
    );
  }
}
