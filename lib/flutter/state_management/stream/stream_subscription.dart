import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: StreamSubscriptionDemo()));
}

class StreamSubscriptionDemo extends StatefulWidget {
  const StreamSubscriptionDemo({super.key});

  @override
  State<StreamSubscriptionDemo> createState() => _StreamSubscriptionDemoState();
}

class _StreamSubscriptionDemoState extends State<StreamSubscriptionDemo> {
  late Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (count) => count).take(10);
  StreamSubscription<int>? subscription;
  final List<String> logs = [];

  @override
  void initState() {
    super.initState();

    subscription = stream.listen(
          (data) {
        addLog('Nhận dữ liệu: $data');

        if (data == 3) {
          addLog('Tạm dừng 1 giây tại $data...');
          subscription!.pause(Future.delayed(const Duration(seconds: 1)));
        }

        if (data == 5) {
          addLog('Hủy subscription tại $data');
          subscription!.cancel();
        }
      },
      onError: (error) => addLog('Lỗi: $error'),
      onDone: () => addLog('Stream đã hoàn thành!'),
    );

    Future.delayed(const Duration(seconds: 7), () {
      addLog('Cập nhật callback mới bằng onData');
      subscription?.onData((data) {
        addLog('Callback mới: $data');
      });
    });
  }

  void addLog(String message) {
    setState(() {
      logs.add('[${DateTime.now().toIso8601String().substring(11, 19)}] $message');
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Subscription Demo')),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) => ListTile(title: Text(logs[index])),
      ),
    );
  }
}
