import 'package:flutter/material.dart';

class LayoutBuilderWidget extends StatelessWidget {
  const LayoutBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Builder')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _horizontalLayout();
          } else {
            return _verticalLayout();
          }
        },
      ),
    );
  }
}

Widget _verticalLayout() {
  List<String> items = List.generate(10, (index) => 'Mục thứ ${index + 1}');
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(
      title: Text(items[index]),
      subtitle: Text('Mô tả: .....................'),
    ),
  );
}

Widget _horizontalLayout() {
  return GridView.count(
    crossAxisCount: 5,
    padding: EdgeInsets.all(15),
    children: List.generate(
      10,
      (index) => Container(
        color: Colors.cyan,
        child: Center(child: Text('Ô số $index')),
      ),
    ),
  );
}
