import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: DragDemo()));

class DragDemo extends StatefulWidget {
  const DragDemo({super.key});

  @override
  State<DragDemo> createState() => _DragDemoState();
}

class _DragDemoState extends State<DragDemo> {
  Offset position = Offset(1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vertical & Horizontal Drag')),
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  position += Offset(0, details.delta.dy);
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  position += Offset(details.delta.dx, 0);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.pink,
                alignment: Alignment.center,
                child: Text(
                  "Drag\n(dọc/ngang)",
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
