import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FileApiScreen());
  }
}

class FileApiScreen extends StatefulWidget {
  const FileApiScreen({super.key});

  @override
  State<FileApiScreen> createState() => _FileApiScreenState();
}

class _FileApiScreenState extends State<FileApiScreen> {
  final controller = TextEditingController();
  String fileContent = "";

  Future<String> get _filePath async {
    final dir = await getApplicationDocumentsDirectory();
    log('${dir.absolute}');
    return '${dir.path}/test_data.txt';
  }

  Future<void> saveToFile() async {
    final path = await _filePath;
    await File(path).writeAsString(controller.text);
  }

  Future<void> readFromFile() async {
    final path = await _filePath;
    final file = File(path);
    if (await file.exists()) {
      setState(() => fileContent = file.readAsStringSync());
    } else {
      setState(() => fileContent = "(No file found)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File API Example')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: controller, decoration: const InputDecoration(labelText: 'Enter text')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: saveToFile, child: const Text('Save to File')),
            ElevatedButton(onPressed: readFromFile, child: const Text('Read from File')),
            const SizedBox(height: 20),
            Text('File Content: $fileContent'),
          ],
        ),
      ),
    );
  }
}
