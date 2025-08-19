import 'package:flutter/material.dart';

// InheritedWidget
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

// Widget con truy cập vào Counter
class ShowCounter extends StatelessWidget {
  const ShowCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final count = Counter.of(context)?.count ?? 0;

    return Text("Count: $count");
  }
}

// Widget chat quản lý trạng thai
class InheritedWidgets extends StatefulWidget {
  const InheritedWidgets({super.key});

  @override
  State<InheritedWidgets> createState() => _InheritedWidgetsState();
}

class _InheritedWidgetsState extends State<InheritedWidgets> {
  int _count = 0;

  void _increment() {
    _count++;

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Counter(
      count: _count,
      child: Scaffold(
        appBar: AppBar(title: Text("InheritedWidgets")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  color: Colors.cyan,
                ),
                child: IconButton(
                  onPressed: _increment,
                  icon: Icon(Icons.add, size: 50),
                ),
              ),
              ShowCounter(),
            ],
          ),
        ),
      ),
    );
  }
}
