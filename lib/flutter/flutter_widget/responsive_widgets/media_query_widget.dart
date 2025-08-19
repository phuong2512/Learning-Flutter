import 'package:flutter/material.dart';

class MediaQueryWidget extends StatelessWidget {
  const MediaQueryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Media Query')),
      body: Center(
        child: Container(
          width: deviceData.size.width,
          height: deviceData.size.height,
          color: deviceData.orientation == Orientation.portrait
              ? Colors.teal // Màu xanh ngọc khi màn hình dọc
              : Colors.orange, // Màu cam khi màn hình ngang
          child: Center(
            child: Text(
              deviceData.orientation == Orientation.portrait ? 'Dọc' : 'Ngang',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
