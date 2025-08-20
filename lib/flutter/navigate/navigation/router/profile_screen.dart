import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/pageless_screen.dart';

class ProfileScreen extends StatelessWidget {
  final int id;

  const ProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as AppRouterDelegate;

    return Scaffold(
      appBar: AppBar(title: Text('Info người dùng #$id')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (id == 250)
              ElevatedButton(
                child: Text('Xem thông tin của người dùng 699'),
                onPressed: () {
                  delegate.goToProfile(699);
                },
              ),
            ElevatedButton(
              child: const Text('Mở pageless route'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Dialog 1'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Bạn có muốn mở screen từ dialog này không?'),
                          ElevatedButton(
                            child: Text('Mở Screen 2 từ dialog'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PagelessRouteScreen()
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Quay lại'),
                          onPressed: () {
                            delegate.goBack();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
