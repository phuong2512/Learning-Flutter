import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/restful_api/http/restful_api_http_demo.dart';
import 'package:learning_flutter/flutter/api/restful_api/dio/restful_api_dio_demo.dart';

void main() {
  runApp(const RESTfulAPIDemoApp());
}

class RESTfulAPIDemoApp extends StatelessWidget {
  const RESTfulAPIDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESTful APIs Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ApiTabDemo(),
    );
  }
}

class ApiTabDemo extends StatelessWidget {
  const ApiTabDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Restful API Demo"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "HTTP"),
              Tab(text: "Dio"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [RestfulApiHttpDemo(), RestfulApiDioDemo()],
        ),
      ),
    );
  }
}
