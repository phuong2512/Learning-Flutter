import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamController Demo',
      home: const StreamControllerDemoScreen(),
    );
  }
}

class StreamControllerDemoScreen extends StatefulWidget {
  const StreamControllerDemoScreen({super.key});

  @override
  State<StreamControllerDemoScreen> createState() =>
      _StreamControllerDemoScreenState();
}

class _StreamControllerDemoScreenState
    extends State<StreamControllerDemoScreen> {
  final StreamController<int> _myController = StreamController<int>();
  Stream<int> get myStream => _myController.stream;

  @override
  void initState() {
    super.initState();
    log('INIT: hasListener=${_myController.hasListener}\n');
  }

  void addData(int data) {
    _myController.add(data);
  }

  void addError(dynamic error) {
    _myController.addError(error);
  }

  @override
  Widget build(BuildContext context) {
    log('Screen State build');
    if (!_myController.isClosed) {
      return Scaffold(
        appBar: AppBar(title: const Text('StreamController Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Stream Data:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),

              StreamBuilder<int>(
                stream: myStream,
                builder: (context, snapshot) {
                  log(
                    'builder called: hasListener=${_myController.hasListener}, connectionState=${snapshot.connectionState}\n',
                  );
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 24),
                    );
                  } else if (snapshot.hasData) {
                    return Text(
                      '${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const Text(
                    'No data yet',
                    style: TextStyle(fontSize: 24),
                  );
                },
              ),

              // StreamBuilder<int>(
              //   stream: null,
              //   builder: (context, snapshot) {
              //     log('StreamBuilder builder called: connectionState=${snapshot.connectionState}\n');
              //     return const Text('No stream', style: TextStyle(fontSize: 24));
              //   },
              // ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addData(DateTime.now().second);
                    },
                    child: const Text('Add Data'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addError('Simulated Error!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Add Error'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _myController.close();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text('Close Stream'),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text(
            'Stream Closed!',
            style: TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ),
      );
    }
  }
}
