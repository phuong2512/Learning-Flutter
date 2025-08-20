import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';

class PagelessRouteScreen extends StatelessWidget {
  const PagelessRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as AppRouterDelegate;
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: Column(
          children: [
            Text('Screen mở từ Dialog 1'),
            TextButton(
              child: Text('Quay về Home luôn'),
              onPressed: () {
                delegate.goBackHome();
              },
            ),
          ],
        ),
      ),
    );
  }
}
