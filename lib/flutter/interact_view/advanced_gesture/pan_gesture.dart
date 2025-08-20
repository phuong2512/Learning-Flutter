import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PanDemo()));

class PanDemo extends StatefulWidget {
  @override
  State<PanDemo> createState() => _PanDemoState();
}

class _PanDemoState extends State<PanDemo> {
  Offset position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pan (free drag)')),
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.center,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    log("${details.delta}");
                    position += details.delta;
                  });
                },
                child: Text(
                  "Pan\n(tự do)",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
