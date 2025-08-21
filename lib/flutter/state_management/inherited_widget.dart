import 'package:flutter/material.dart';

class Counter extends InheritedWidget {
  final int count;
  const Counter({required this.count, super.key, required super.child});

  static Counter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Counter>();
  }

  @override
  bool updateShouldNotify(Counter oldWidget) {
    return count != oldWidget.count;
  }
}

class ShowCounter extends StatelessWidget {
  const ShowCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final count = Counter.of(context)?.count ?? 0;

    return Text("Count: $count");
  }
}

class InheritedWidgetDemo extends StatefulWidget {
  const InheritedWidgetDemo({super.key});

  @override
  State<InheritedWidgetDemo> createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Counter(
      count: _count,
      child: Scaffold(
        appBar: AppBar(title: Text("InheritedWidget Demo")),
        body: Center(child: ShowCounter()),
        floatingActionButton: FloatingActionButton(
          onPressed: _increment,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: InheritedWidgetDemo()));
}
