import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const SecureStorageDemo());
}

class SecureStorageDemo extends StatefulWidget {
  const SecureStorageDemo({super.key});

  @override
  State<SecureStorageDemo> createState() => _SecureStorageDemoState();
}

class _SecureStorageDemoState extends State<SecureStorageDemo> {
  final storage = const FlutterSecureStorage();
  final controller = TextEditingController();
  String? savedToken;

  Future<void> saveToken() async {
    await storage.write(key: 'token', value: controller.text);
    setState(() => savedToken = controller.text);
  }

  Future<void> loadToken() async {
    final token = await storage.read(key: 'token');
    setState(() => savedToken = token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Secure Storage Example')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Enter token'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: saveToken, child: const Text('Save')),
              ElevatedButton(onPressed: loadToken, child: const Text('Load')),
              const SizedBox(height: 20),
              Text('Saved Token: ${savedToken ?? "(none)"}'),
            ],
          ),
        ),
      ),
    );
  }
}