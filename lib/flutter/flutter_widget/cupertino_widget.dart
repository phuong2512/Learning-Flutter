import 'dart:developer';

import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyCupertinoApp());
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Cupertino Demo',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.refresh),
          onPressed: () {
            log("Refresh button pressed");
          },
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Cupertino!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: _toggleLoading,
              color: CupertinoColors.activeGreen,
              child: const Text('Toggle Activity Indicator'),
            ),
            const SizedBox(height: 30),
            if (_isLoading) const CupertinoActivityIndicator(radius: 20.0),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
