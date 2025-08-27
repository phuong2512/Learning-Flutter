import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/storage/share_preferences/shared_preferences_demo.dart';
import 'package:learning_flutter/flutter/storage/share_preferences/shared_preferences_async_demo.dart';
import 'package:learning_flutter/flutter/storage/share_preferences/shared_preferences_with_cache_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn API để test")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("SharedPreferences"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SharedPreferencesDemo())),
          ),
          ListTile(
            title: const Text("SharedPreferencesAsync"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SharedPreferencesAsyncDemo())),
          ),
          ListTile(
            title: const Text("SharedPreferencesWithCache"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SharedPreferencesWithCacheDemo())),
          ),
        ],
      ),
    );
  }
}
