import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: TrafficLightApp()));
}

abstract class TrafficLightState {
  Color getColor();
  String getCurrentState();
  TrafficLightState nextState(); 
}

class RedState implements TrafficLightState {
  @override
  Color getColor() => Colors.red;

  @override
  String getCurrentState() => "ĐÈN ĐỎ - DỪNG";

  @override
  TrafficLightState nextState() => GreenState();
}

class GreenState implements TrafficLightState {
  @override
  Color getColor() => Colors.green;

  @override
  String getCurrentState() => "ĐÈN XANH - ĐI";

  @override
  TrafficLightState nextState() => YellowState();
}

class YellowState implements TrafficLightState {
  @override
  Color getColor() => Colors.yellow;

  @override
  String getCurrentState() => "ĐÈN VÀNG - CHẬM LẠI";

  @override
  TrafficLightState nextState() => RedState();
}

class TrafficLightApp extends StatefulWidget {
  const TrafficLightApp({super.key});

  @override
  State<TrafficLightApp> createState() => _TrafficLightAppState();
}

class _TrafficLightAppState extends State<TrafficLightApp> {
  TrafficLightState _currentState = RedState();

  void _nextLight() {
    setState(() {
      _currentState = _currentState.nextState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Light")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentState.getCurrentState(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _currentState.getColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _nextLight, child: const Text("Next")),
          ],
        ),
      ),
    );
  }
}
