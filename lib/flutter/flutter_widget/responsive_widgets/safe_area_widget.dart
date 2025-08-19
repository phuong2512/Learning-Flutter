import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeArea Widget')),
      body: SafeArea(
        // bottom: false, //bottom có thể bị thanh điều hướng của thiết bị che mất
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nội dung ở đầu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Nhấn nút')),
            Container(
              color: Colors.amber,
              width: double.infinity,
              child: Text(
                'Nội dung ở cuối',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
