import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as AppRouterDelegate;

    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Xem thông tin của người dùng 250'),
              onPressed: () {
                delegate.goToProfile(250);
              },
            ),
            ElevatedButton(
              child: Text('Xem thông tin của người dùng 699'),
              onPressed: () {
                delegate.goToProfile(699);
              },
            ),
            ElevatedButton(
              onPressed: () {
                delegate.goToSettings();
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
