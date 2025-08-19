import 'package:flutter/material.dart';

class OrientationBuilderWidget extends StatelessWidget {
  const OrientationBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orientation Builder')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _verticalLayout()
              : _horizontalLayout();
        },
      ),
    );
  }
}

Widget _verticalLayout() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.red,
    child: Center(child: Text("Dọc", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)),
  );
}

Widget _horizontalLayout() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.blue,
    child: Center(child: Text("Ngang", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)),
  );
}
