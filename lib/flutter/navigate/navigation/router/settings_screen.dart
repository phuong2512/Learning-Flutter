import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as AppRouterDelegate;

    return Scaffold(
      appBar: AppBar(title: Text("Settings Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
            child: Text('Change Profile'),
            onPressed: () {
              delegate.goToChangeProfile();
            },
          ),
            ElevatedButton(
              onPressed: () => delegate.goBackHome(),
              child: const Text("Navigator (pop)"),
            ),
          ],
        ),
      ),
    );
  }
}
