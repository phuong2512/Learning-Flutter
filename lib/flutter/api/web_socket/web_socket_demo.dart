import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebSocketDemo(),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  const WebSocketDemo({super.key});

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  late WebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.ifelse.io'),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Nhập tin nhắn",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Tin nhắn từ server:"),
            Expanded(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    return Text("Lỗi: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Đang kết nối...");
                  }
                  return Text(snapshot.data?.toString() ?? "");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
