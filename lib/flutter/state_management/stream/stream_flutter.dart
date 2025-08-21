import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const StreamDemoApp());

class StreamDemoApp extends StatelessWidget {
  const StreamDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Creation Methods',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StreamDemoScreen(),
    );
  }
}

class StreamDemoScreen extends StatefulWidget {
  const StreamDemoScreen({super.key});

  @override
  State<StreamDemoScreen> createState() => _StreamDemoScreenState();
}

class _StreamDemoScreenState extends State<StreamDemoScreen> {
  // 1. async*
  Stream<int> countStream(int max) async* {
    for (int i = 1; i <= max; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  // // 2. Stream.error
  // Stream<String> errorStream() {
  //   try {
  //     riskyOperation();
  //     return Stream.value('Thành công');
  //   } catch (e, stackTrace) {
  //     return Stream.error(e, stackTrace);
  //   }
  // }

  void riskyOperation() {
    throw Exception('Lỗi từ riskyOperation!');
  }

  // 3. Stream.eventTransformed
  Stream<int> transformedStream() {
    final source = Stream.fromIterable([1, 2, 3, 4]);
    return Stream.eventTransformed(
      source,
          (sink) => _DoubleSink(sink),
    );
  }

  // 4. Stream.fromFuture
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Dữ liệu từ Future';
  }

  // 5. Stream.fromFutures
  Stream<String> multiFutureStream() {
    return Stream.fromFutures([
      Future.delayed(const Duration(seconds: 1), () => 'Future 1'),
      Future.delayed(const Duration(seconds: 3), () => 'Future 2'),
      Future.delayed(const Duration(seconds: 5), () => 'Future 3'),
    ]);
  }

  // 6. Stream.iterableStream
  Stream<int> iterableStream() {
    return Stream.fromIterable([10, 20, 30, 40, 50]);
  }

  // 7. Stream.periodic
  Stream<int> periodicStream() {
    return Stream.periodic(
        const Duration(seconds: 1),
            (count) => count * count
    ).takeWhile((n) => n < 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Các Phương Pháp Tạo Stream'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStreamCard(
            title: '1. async*',
            description: 'Tạo stream từ hàm async* với yield',
            stream: countStream(50),
            color: Colors.blue[100]!,
          ),

          // _buildStreamCard(
          //   title: '2. Stream.error',
          //   description: 'Xử lý lỗi với Stream.error',
          //   stream: errorStream(),
          //   color: Colors.red[100]!,
          // ),

          _buildStreamCard(
            title: '3. Stream.eventTransformed ',
            description: 'Sử dụng Stream.eventTransformed',
            stream: transformedStream(),
            color: Colors.green[100]!,
          ),

          _buildStreamCard(
            title: '4. Stream.fromFuture',
            description: 'Chuyển Future thành Stream',
            stream: Stream.fromFuture(fetchData()),
            color: Colors.amber[100]!,
          ),

          _buildStreamCard(
            title: '5. Stream.fromFutures',
            description: 'Stream.fromFutures với nhiều tác vụ',
            stream: multiFutureStream(),
            color: Colors.purple[100]!,
          ),

          _buildStreamCard(
            title: '6. Stream.fromIterable',
            description: 'Stream.fromIterable với danh sách',
            stream: iterableStream(),
            color: Colors.teal[100]!,
          ),

          _buildStreamCard(
            title: '7. Stream.periodic',
            description: 'Stream.periodic với bộ đếm',
            stream: periodicStream(),
            color: Colors.orange[100]!,
          ),

          _buildStreamCard(
            title: '8. Stream.value',
            description: 'Stream.value với giá trị tĩnh',
            stream: Stream.value(99),
            color: Colors.indigo[100]!,
          ),
        ],
      ),
    );
  }

  Widget _buildStreamCard({
    required String title,
    required String description,
    required Stream<dynamic> stream,
    required Color color,
  }) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            )),
            const SizedBox(height: 12),
            StreamBuilder<dynamic>(
              stream: stream,
              builder: (context, snapshot) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildStreamContent(snapshot),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamContent(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Đang tải dữ liệu...'),
        ],
      );
    }
    if (snapshot.hasData) {
      final data = snapshot.data;
      return Text('✅ $data', style: const TextStyle(fontSize: 16));
    }

    return const Text('No Data');
  }
}

class _DoubleSink implements EventSink<int> {
  final EventSink<int> _sink;
  _DoubleSink(this._sink);

  @override
  void add(int event) => _sink.add(event * 2);

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _sink.addError(error, stackTrace);

  @override
  void close() => _sink.close();
}