import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

Stream<int> myBroadcastStream() {
  final myStreamController = StreamController<int>.broadcast();
  Future(() async {
    var counter = 0;
    for (var i = 0; i < 20; i++) {
      await Future.delayed(Duration(seconds: 1));
      counter++;
      myStreamController.add(counter);
    }
    myStreamController.close();
  });
  return myStreamController.stream;
}

// void main() async {
//   final stream = myStream();
//   print('Bắt đầu đếm từ 1 đến 5');
//   stream.listen(
//         (count) => print(count),
//     onDone: () => print('Hoàn tất'),
//     onError: (e) => print('Lỗi: $e'),
//   );
//   await Future.delayed(Duration(seconds: 3));
//   stream.listen(
//         (count) => print(count),
//     onDone: () => print('Hoàn tất'),
//     onError: (e) => print('Lỗi: $e'),
//   );
//   await Future.delayed(Duration(seconds: 4));
//   stream.listen(
//         (count) => print(count),
//     onDone: () => print('Hoàn tất'),
//     onError: (e) => print('Lỗi: $e'),
//   );
//
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BroadcastStreamExample());
  }
}

class BroadcastStreamExample extends StatefulWidget {
  const BroadcastStreamExample({super.key});

  @override
  State<BroadcastStreamExample> createState() => _BroadcastStreamExampleState();
}

class _BroadcastStreamExampleState extends State<BroadcastStreamExample> {
  late final Stream<int> _stream;
  final List<String> logs = [];

  @override
  void initState() {
    super.initState();
    _stream = myBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StreamController Broadcast")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Count 1 to 5"),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: _stream,
              initialData: 0,
              builder: (context, snapshot) {
                log(
                  'StreamBuilder 1: connectionState=${snapshot.connectionState}',
                );
                return _buildStreamContent(snapshot, 'Listener 1');
              },
            ),
            const Divider(height: 20, thickness: 5, indent: 50, endIndent: 50),
            StreamBuilder<int>(
              stream: _stream,
              initialData: 0,
              builder: (context, snapshot) {
                log(
                  'StreamBuilder 2: connectionState=${snapshot.connectionState}\n',
                );
                return _buildStreamContent(snapshot, 'Listener 2');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStreamContent(AsyncSnapshot<int> snapshot, String listenerName) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
  } else if (snapshot.hasError) {
    return Text(
      'Error: ${snapshot.error}',
      style: const TextStyle(color: Colors.red, fontSize: 24),
    );
  } else if (snapshot.hasData &&
      snapshot.connectionState != ConnectionState.done) {
    return Text(
      '${snapshot.data}',
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );
  } else if (snapshot.connectionState == ConnectionState.done) {
    log('$listenerName ended: ${snapshot.connectionState}');
    return Text('$listenerName ended', style: const TextStyle(fontSize: 24));
  }

  return Text('No data yet', style: const TextStyle(fontSize: 24));
}
