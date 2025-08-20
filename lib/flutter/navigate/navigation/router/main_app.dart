import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routerDelegate = AppRouterDelegate();
  final _routeParser = AppRouteParser();
  late final _backButtonDispatcher = AppBackButtonDispatcher(_routerDelegate);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeParser,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}
