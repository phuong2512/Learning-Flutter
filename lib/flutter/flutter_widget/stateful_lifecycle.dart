import 'package:flutter/material.dart';
import 'dart:developer';

class StatefulLifecycle extends StatefulWidget {
  const StatefulLifecycle({super.key});

  @override
  State<StatefulLifecycle> createState() => _StatefulLifecycleState();
}

class _StatefulLifecycleState extends State<StatefulLifecycle> {
  int _count = 0;
  String _parentMessage = "Thông điệp ban đầu từ parent";
  String _themeName = "Light"; // Giá trị ban đầu cho theme

  @override
  void initState() {
    super.initState();
    log('initState');
  }

  void _increment() {
    setState(() {
      _count++;
      _parentMessage = "Đếm: $_count";
      log('setState: Count = $_count');
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeName = _themeName == "Light" ? "Dark" : "Light";
      log('setState: Theme changed to $_themeName');
    });
  }

  @override
  Widget build(BuildContext context) {
    log('build');

    return ThemeConfig(
      themeName: _themeName,
      child: Scaffold(
        appBar: AppBar(title: const Text('StatefulWidget Lifecycle')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đếm: $_count',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              ChildWidget(message: _parentMessage),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _increment, child: const Text('Tăng')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleTheme,
                child: Text('Đổi Theme (Hiện tại: $_themeName)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    log('deactivate');
  }

  @override
  void dispose() {
    log('dispose');
    super.dispose();
  }
}

class ChildWidget extends StatefulWidget {
  final String message;

  const ChildWidget({super.key, required this.message});

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  String? _currentTheme;

  @override
  void initState() {
    super.initState();
    log('ChildWidget: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeConfig = ThemeConfig.of(context);
    _currentTheme = themeConfig?.themeName;
    log('ChildWidget: didChangeDependencies - Theme: $_currentTheme');
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('ChildWidget: didUpdateWidget - Old message: ${oldWidget.message}, New message: ${widget.message}');
  }

  @override
  Widget build(BuildContext context) {
    log('ChildWidget: build');
    return Text(
      'Message: ${widget.message}\nTheme: $_currentTheme',
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.secondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  void dispose() {
    log('ChildWidget: dispose');
    super.dispose();
  }
}


class ThemeConfig extends InheritedWidget {
  final String themeName;

  const ThemeConfig({
    super.key,
    required this.themeName,
    required super.child,
  });

  static ThemeConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeConfig>();
  }

  @override
  bool updateShouldNotify(ThemeConfig oldWidget) {
    return themeName != oldWidget.themeName;
  }
}