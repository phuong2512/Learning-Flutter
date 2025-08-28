import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // Tạo 256-bit key (32 bytes)
  var secureKey = List<int>.generate(32, (i) => Random().nextInt(256));
  var encryptionKey = HiveAesCipher(secureKey);

  // Mở box với key
  var box = await Hive.openBox(
    'secureBox',
    encryptionCipher: encryptionKey,
  );

  // Ghi dữ liệu
  await box.put('secret', 'This is encrypted data!');

  // Đọc dữ liệu
  print('Decrypted: ${box.get('secret')}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Hive Encryption")),
        body: const Center(
          child: Text("Hive data is encrypted on disk"),
        ),
      ),
    );
  }
}
