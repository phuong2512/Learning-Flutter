import 'dart:developer';

import 'package:flutter/material.dart';

abstract class ImageLoaderInterface {
  Future<Image> loadImage(String url);
}

class ImageLoader implements ImageLoaderInterface {
  @override
  Future<Image> loadImage(String url) async {
    log('Đang tải hình ảnh từ mạng: $url');
    await Future.delayed(Duration(seconds: 2));
    return Image.network(url);
  }
}

class ImageLoaderProxy implements ImageLoaderInterface {
  final ImageLoader _imageLoader = ImageLoader();
  final Map<String, Image> _imageCache = {};

  @override
  Future<Image> loadImage(String url) async {
    if (_imageCache.containsKey(url)) {
      log('Lấy hình ảnh từ cache: $url');
      return _imageCache[url]!;
    }

    print('Không tìm thấy trong cache, tải từ mạng: $url');
    final image = await _imageLoader.loadImage(url);
    _imageCache[url] = image;
    return image;
  }
}

// Ứng dụng Flutter
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String imageUrl = 'https://cdn.cdnstep.com/6rlpP263SVQGrZjBxChe/12.webp';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final imageLoader = ImageLoaderProxy();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Proxy Pattern Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Image>(
                future: imageLoader.loadImage(imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Text('Lỗi khi tải hình ảnh');
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  imageLoader.loadImage(imageUrl);
                },
                child: Text('Tải lại hình ảnh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}