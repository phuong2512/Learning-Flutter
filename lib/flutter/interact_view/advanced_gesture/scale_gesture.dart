import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ScaleDemo()));

class ScaleDemo extends StatefulWidget {
  const ScaleDemo({super.key});

  @override
  State<ScaleDemo> createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<ScaleDemo> {
  double _scale = 1.0;
  double _rotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scale + Rotate')),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _scale = details.scale;
              _rotation = details.rotation;
              log("Scale: $_scale, Rotation: $_rotation");
            });
          },
          child: Transform.rotate(
            angle: _rotation,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.green,
                alignment: Alignment.center,
                child: Text("Scale + Rotate",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
