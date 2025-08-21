import 'dart:async';

import 'package:flutter/material.dart';

Stream<int> myStream() {
  final myStreamController = StreamController<int>();
  Future(() async {
    var counter = 0;
    for (var i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      counter++;
      myStreamController.add(counter);
    }
    myStreamController.close();
  });

  return myStreamController.stream;
}

void main() async {
  // print('Bắt đầu đếm từ 1 đến 5');
  // stream.listen(
  //   (count) => print(count),
  //   onDone: () => print('Hoàn tất'),
  //   onError: (e) => print('Lỗi: $e'),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Counter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SingleSubStream(),
    );
  }
}

class SingleSubStream extends StatefulWidget {
  const SingleSubStream({super.key});

  @override
  State<SingleSubStream> createState() => _SingleSubStreamState();
}

class _SingleSubStreamState extends State<SingleSubStream> {
  final stream = myStream();

  StreamSubscription? _countSub;

  var _number = 0;

  @override
  void initState() {
    super.initState();
    _countSub = stream.listen((value) {
      setState(() {
        _number = value;
      });
    });
  }

  @override
  void dispose() {
    _countSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamController Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Let's count"), Text("Counter: $_number")],
        ),
      ),
    );
  }
}
