import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  timeDilation = 5.0;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListScreen());
  }
}

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final List<Map<String, String>> _hero = [
    {
      'title': 'Hero Image 1',
      'tag': 'hero-image-1',
      'img': 'assets/images/cat_1.png',
    },
    {
      'title': 'Hero Image 2',
      'tag': 'hero-image-2',
      'img': 'assets/images/cat_2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation List')),
      body: ListView.builder(
        itemCount: _hero.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              createRectTween: (begin, end) {
                return RectTween(begin: begin, end: end); // Bay thẳng
              },
              tag: _hero[index]['tag']!,
              child: Image.asset(
                _hero[index]['img']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(_hero[index]['title']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(hero: _hero[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, String> hero;

  const DetailScreen({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hero['title']!)),
      body: Center(
        child: Hero(
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end); // Bay thẳng
          },
          tag: hero['tag']!,
          child: Image.asset(
            hero['img']!,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
