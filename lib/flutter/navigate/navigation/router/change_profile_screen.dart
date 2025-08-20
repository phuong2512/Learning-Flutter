import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';

class ChangeProfileScreen extends StatelessWidget {
  const ChangeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as AppRouterDelegate;

    return Scaffold(
      appBar: AppBar(title: Text("Change Profile Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
