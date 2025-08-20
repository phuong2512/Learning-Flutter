import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: TxtReaderWidget()));
}

class TxtReaderWidget extends StatelessWidget {
  const TxtReaderWidget({super.key});

  Future<String> loadTextFromAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/data/info.txt');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadTextFromAsset(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Lỗi: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Read File Example')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(snapshot.data ?? ''),
            ),
          );
        }
      },
    );
  }
}

