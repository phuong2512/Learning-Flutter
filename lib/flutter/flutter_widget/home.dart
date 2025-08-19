import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/flutter_widget/inherited_widgets.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/responsive_widgets.dart';
import 'package:learning_flutter/flutter/flutter_widget/stateful_lifecycle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  void _onChangeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = <Widget>[
    ResponsiveWidgets(),
    InheritedWidgets(),
    StatefulLifecycle(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onChangeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Responsive'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dark_mode),
            label: 'Inherited',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: 'Stateful',
          ),
        ],
      ),
      appBar: AppBar(title: Text('Widget Demo')),
      body: _screens[_selectedIndex],
    );
  }
}
